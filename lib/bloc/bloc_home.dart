import 'package:Anifrag/bloc/bloc_maintab_bar.dart';
import 'package:Anifrag/bloc/dispose_bag.dart';
import 'package:Anifrag/di/module/module_store.dart';
import 'package:Anifrag/model/responses/response_cast.dart';
import 'package:Anifrag/model/responses/response_home_page_movie.dart';
import 'package:Anifrag/model/responses/response_movie.dart';
import 'package:Anifrag/network/apis.dart';
import 'package:Anifrag/store/app_db.dart';
import 'package:Anifrag/store/offline/offline_cast.dart';
import 'package:Anifrag/store/offline/offline_movie.dart';
import 'package:dartz/dartz.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/subjects.dart';

enum MoveDetailState { loading, finish }

const int _indexForListCarousel = 0;
const int _maxNumEachPage = 20;

@provide
class BlocHome with DisposeBag {
  // final LiveStore _liveStore;
  List<ResponseThumbnailMovie> homePageData;
  List<String> categories;
  Map<String, List<ResponseThumbnailMovie>> tvShowData;
  final API _api;
  final OfflineMovie _offMovie;
  final OfflineCast _offCast;
  final AppDb _appDb;
  final String baseUrlImage;
  final BlocMainTabbar _blocMainTabbar;
  BlocMainTabbar get blocMainTabbar => _blocMainTabbar;

  final subjectMoveDetailState = PublishSubject<
      Either<Null, Tuple4<ResponseMovie, List<ResponseCast>, bool, String>>>();

  static BlocHome init(
      BlocHome blocModule,
      List<ResponseThumbnailMovie> homePageData,
      List<String> categories,
      Map<String, List<ResponseThumbnailMovie>> tvShowData) {
    blocModule
      ..homePageData = homePageData
      ..categories = categories
      ..tvShowData = tvShowData;
    return blocModule;
  }

  BlocHome(
      // this._liveStore,
      this._api,
      this._offMovie,
      this._offCast,
      this._appDb,
      this._blocMainTabbar,
      @baseUrlImg this.baseUrlImage) {
    dropStream(subjectMoveDetailState);
  }

  List<ResponseThumbnailMovie> getListCarousel() {
    // First 20 records is belong to carousel/
    return homePageData.sublist(_indexForListCarousel, _maxNumEachPage);
  }

  Map<String, List<ResponseThumbnailMovie>> getListRestMovies() {
    final result = Map<String, List<ResponseThumbnailMovie>>();
    int pivot = _indexForListCarousel + 1;
    int lastEnd = _maxNumEachPage;

    while (pivot < categories.length) {
      final start = lastEnd;
      final end = start + _maxNumEachPage;
      lastEnd = end;
      result[categories[pivot]] = homePageData.sublist(start, end);
      pivot++;
    }
    return result;
  }

  void moveDetailProcess(int idMovie, String prefix) async {
    bool isCallFailed = false;
    ResponseMovie movieDetail;
    List<ResponseCast> movieCasts;

    subjectMoveDetailState.add(Left(null));

    try {
      movieDetail = await _api.getMovieDetail(idMovie);
      movieCasts = await _api.getCasts(idMovie);
    } catch (er) {
      isCallFailed = true;
      _blocMainTabbar.triggerPopupLong();
    }

    if (!isCallFailed) {
      subjectMoveDetailState
          .add(Right(Tuple4(movieDetail, movieCasts, true, prefix)));
      final db = await _appDb.db;
      db.transaction((txn) async {
        final batch = txn.batch();

        batch.execute(_offMovie.queryDeleteOneMovie(movieDetail.id));
        batch.execute(_offCast.queryDeleteAllCastWithIdMovie(movieDetail.id));

        batch.execute(_offMovie.queryInsertOneMovie(movieDetail));
        _offCast
            .queryInsertCasts(movieCasts, movieDetail.id)
            .forEach((castQuery) {
          batch.execute(castQuery);
        });

        batch.commit();
      });
      await _appDb.closeDb();
    } else {
      // Get from offline here
      final db = await _appDb.db;
      await db.transaction((txn) async {
        try {
          final List<dynamic> queries = await Future.wait([
            txn.rawQuery(_offMovie.querySelectMovie(idMovie)),
            txn.rawQuery(_offCast.querySelectCasts(idMovie))
          ]);

          final responseMovie = ResponseMovie.fromJson(queries[0][0]);
          final responseCast = (queries[1] as List<Map>)
              .map<ResponseCast>((f) => ResponseCast.fromJson(f))
              .toList();
          // _moveToDetail(context, responseMovie, responseCast, true, prefix);
          subjectMoveDetailState
              .add(Right(Tuple4(responseMovie, responseCast, true, prefix)));
        } catch (er) {
          // _moveToDetail(context, null, null, false, prefix);
          subjectMoveDetailState.add(Right(Tuple4(null, null, false, prefix)));
        }
      });
      await _appDb.closeDb();
    }
  }

  String get getMainCategory => categories[0];
}

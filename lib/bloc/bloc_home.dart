import 'dart:collection';

import 'package:Anifrag/bloc/bloc_maintab_bar.dart';
import 'package:Anifrag/bloc/dispose_bag.dart';
import 'package:Anifrag/di/module/module_store.dart';
import 'package:Anifrag/model/business/business_movie.dart';
import 'package:Anifrag/model/responses/response_cast.dart';
import 'package:Anifrag/model/responses/response_home_page_movie.dart';
import 'package:Anifrag/network/apis.dart';
import 'package:Anifrag/store/app_db.dart';
import 'package:Anifrag/store/offline/offline_cast.dart';
import 'package:Anifrag/store/offline/offline_movie.dart';
import 'package:dartz/dartz.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/subjects.dart';

enum MoveDetailState { loading, finish }

@provide
class BlocHome with DisposeBag {
  // final LiveStore _liveStore;
  LinkedHashMap<String, List<ResponseThumbnailMovie>> homePageData;
  Map<String, List<ResponseThumbnailMovie>> _listRestMovies;
  final API _api;
  final OfflineMovie _offMovie;
  final OfflineCast _offCast;
  final AppDb _appDb;
  final String baseUrlImage;
  final BlocMainTabbar _blocMainTabbar;
  final PublishSubject<
          Either<Null, Tuple4<BusinessMovie, List<ResponseCast>, bool, String>>>
      stateMovieDetail = PublishSubject();

  BlocMainTabbar get blocMainTabbar => _blocMainTabbar;

  static BlocHome init(BlocHome blocModule,
      Map<String, List<ResponseThumbnailMovie>> homePageData) {
    blocModule..homePageData = homePageData;
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
    dropStream(stateMovieDetail);
  }

  List<ResponseThumbnailMovie> get getListCarousel {
    // First 20 records is belong to carousel/
    return homePageData[homePageData.keys.first];
  }

  Map<String, List<ResponseThumbnailMovie>> get getListRestMovies {
    if (_listRestMovies == null) {
      final clone = LinkedHashMap<String, List<ResponseThumbnailMovie>>();
      clone.addAll(homePageData);
      clone.remove(homePageData.keys.first);
      _listRestMovies = clone;
    }
    return _listRestMovies;
  }

  moveDetailProcess(int idMovie, String prefix, bool isTv) async {
    bool isCallFailed = false;
    BusinessMovie movieDetail;
    List<ResponseCast> movieCasts;

    stateMovieDetail.add(Left(null));

    try {
      if (isTv) {
        movieDetail = BusinessMovie.tv(await _api.getTvDetail(idMovie));
        movieCasts = [];
      } else {
        movieDetail = BusinessMovie.movie(await _api.getMovieDetail(idMovie));
        movieCasts = await _api.getCasts(idMovie);
      }
    } catch (er) {
      isCallFailed = true;
      _blocMainTabbar.triggerPopupLong();
    }

    if (!isCallFailed) {
      stateMovieDetail
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

          final responseMovie = BusinessMovie.fromJson(queries[0][0]);
          final responseCast = (queries[1] as List<Map>)
              .map<ResponseCast>((f) => ResponseCast.fromJson(f))
              .toList();
          stateMovieDetail
              .add(Right(Tuple4(responseMovie, responseCast, true, prefix)));
        } catch (er) {
          stateMovieDetail.add(Right(Tuple4(null, null, false, prefix)));
        }
      });
      await _appDb.closeDb();
    }
  }

  String get getMainCategory => homePageData.keys.first;
}

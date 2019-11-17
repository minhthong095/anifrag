import 'package:Anifrag/bloc/bloc_maintabbar.dart';
import 'package:Anifrag/model/responses/response_cast.dart';
import 'package:Anifrag/model/responses/response_home_page_movie.dart';
import 'package:Anifrag/model/responses/response_movie.dart';
import 'package:Anifrag/network/apis.dart';
import 'package:Anifrag/store/app_db.dart';
import 'package:Anifrag/store/live_store.dart';
import 'package:Anifrag/store/offline/offline_cast.dart';
import 'package:Anifrag/store/offline/offline_movie.dart';
import 'package:dio/dio.dart';
import 'package:sqflite/sqflite.dart';

class BlocHome {
  LiveStore _liveStore;
  AbsAPI _api;
  OfflineMovie _offMovie;
  OfflineCast _offCast;
  AppDb _appDb;

  // inject in my_app.dart
  BlocMainTabbar blocMainTabbar;

  BlocHome(
      this._liveStore, this._api, this._offMovie, this._offCast, this._appDb);

  static const int _indexForListCarousel = 0;
  static const int maxNumEachPage = 20;

  List<ResponseThumbnailMovie> listCarousel() {
    // First 20 records is belong to carousel/
    return _liveStore.homePageData
        .sublist(_indexForListCarousel, maxNumEachPage);
  }

  Map<String, List<ResponseThumbnailMovie>> listRestMovies() {
    final result = Map<String, List<ResponseThumbnailMovie>>();
    int pivot = _indexForListCarousel + 1;
    int lastEnd = maxNumEachPage;
    while (pivot < _liveStore.categories.length) {
      final start = lastEnd;
      final end = start + maxNumEachPage;
      lastEnd = end;
      result[_liveStore.categories[pivot]] =
          _liveStore.homePageData.sublist(start, end);
      // print("START $start END $end");
      pivot++;
    }
    return result;
  }

  void getMovie(
      int idMovie,
      Function(ResponseMovie, List<ResponseCast>, bool isSuccess)
          callback) async {
    bool isCallFailed = false;
    ResponseMovie movieDetail;
    List<ResponseCast> movieCasts;
    try {
      movieDetail = await _api.getMovieDetail(idMovie);
      movieCasts = await _api.getCasts(idMovie);
    } catch (er) {
      isCallFailed = true;
      blocMainTabbar.triggerPopup();
    }

    if (!isCallFailed) {
      callback(movieDetail, movieCasts, true);
      final db = await _appDb.getDb();
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
      final db = await _appDb.getDb();
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

          callback(responseMovie, responseCast, true);
        } catch (er) {
          callback(null, null, false);
        }
      });
      await _appDb.closeDb();
    }
  }

  String mainCategory() => _liveStore.categories[0];

  String baseUrlImage() =>
      _liveStore.responseConfiguration.images.secureBaseUrl;
}

// 485057808

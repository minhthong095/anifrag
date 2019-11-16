import 'package:Anifrag/model/responses/response_cast.dart';
import 'package:Anifrag/model/responses/response_home_page_movie.dart';
import 'package:Anifrag/model/responses/response_movie.dart';
import 'package:Anifrag/network/apis.dart';
import 'package:Anifrag/store/app_db.dart';
import 'package:Anifrag/store/live_store.dart';
import 'package:Anifrag/store/offline/offline_cast.dart';
import 'package:Anifrag/store/offline/offline_movie.dart';
import 'package:dio/dio.dart';

class BlocHome {
  LiveStore _liveStore;
  AbsAPI _api;
  OfflineMovie _offMovie;
  OfflineCast _offCast;
  AppDb _appDb;

  BlocHome(
      this._liveStore, this._api, this._offMovie, this._offCast, this._appDb);

  static const int _indexForListCarousel = 0;
  static const int maxNumEachPage = 20;

  List<ResponseHomePageMovie> listCarousel() {
    // First 20 records is belong to carousel/
    return _liveStore.homePageData
        .sublist(_indexForListCarousel, maxNumEachPage);
  }

  Map<String, List<ResponseHomePageMovie>> listRestMovies() {
    final result = Map<String, List<ResponseHomePageMovie>>();
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
      int idMovie, Function(ResponseMovie, List<ResponseCast>) callback) async {
    final movieDetail = await _api.getMovieDetail(idMovie);
    final movieCasts = await _api.getCasts(idMovie);
    callback(movieDetail, movieCasts);
    final db = await _appDb.getDb();
    await db.transaction((txn) async {
      final batch = txn.batch();
      _offMovie.queryInsertOneMovie(movieDetail);
      _offCast.queryInsertCasts(movieCasts, movieDetail.id);
      batch.rawInsert(_offMovie.queryInsertOneMovie(movieDetail));
      _offCast
          .queryInsertCasts(movieCasts, movieDetail.id)
          .forEach((castQuery) {
        batch.rawInsert(castQuery);
      });
      batch.commit();
    });
    await _appDb.closeDb();
  }

  String mainCategory() => _liveStore.categories[0];

  String baseUrlImage() =>
      _liveStore.responseConfiguration.images.secureBaseUrl;
}

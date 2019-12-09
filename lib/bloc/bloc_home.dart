import 'package:Anifrag/bloc/bloc_maintab_bar.dart';
import 'package:Anifrag/model/responses/response_cast.dart';
import 'package:Anifrag/model/responses/response_home_page_movie.dart';
import 'package:Anifrag/model/responses/response_movie.dart';
import 'package:Anifrag/network/apis.dart';
import 'package:Anifrag/store/app_db.dart';
import 'package:Anifrag/store/live_store.dart';
import 'package:Anifrag/store/offline/offline_cast.dart';
import 'package:Anifrag/store/offline/offline_movie.dart';
import 'package:Anifrag/ui/screen/detail.dart';
import 'package:Anifrag/ui/widget/loading_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

class BlocHome {
  final LiveStore _liveStore;
  final API _api;
  final OfflineMovie _offMovie;
  final OfflineCast _offCast;
  final AppDb _appDb;
  final BlocMainTabbar _blocMainTabbar;
  BlocMainTabbar get blocMainTabbar => _blocMainTabbar;

  BlocHome(this._liveStore, this._api, this._offMovie, this._offCast,
      this._appDb, this._blocMainTabbar);

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

  void _moveToDetail(BuildContext context, ResponseMovie movieDetail,
      List<ResponseCast> movieCasts, bool isSucces, String prefix) {
    Navigator.of(context).popUntil(LoadingRoute.loadingRoutePredicate());
    if (isSucces)
      Navigator.of(context).pushNamed(DetailScreen.nameRoute,
          arguments: DetailScreenArgument(prefix, movieDetail, movieCasts));
  }

  void moveDetailProcess(
      BuildContext context, int idMovie, String prefix) async {
    bool isCallFailed = false;
    ResponseMovie movieDetail;
    List<ResponseCast> movieCasts;

    Navigator.of(context).pushNamed(LoadingRoute.nameRoute);

    try {
      movieDetail = await _api.getMovieDetail(idMovie);
      movieCasts = await _api.getCasts(idMovie);
    } catch (er) {
      isCallFailed = true;
      _blocMainTabbar.triggerPopupLong();
    }

    if (!isCallFailed) {
      _moveToDetail(context, movieDetail, movieCasts, true, prefix);
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

          _moveToDetail(context, responseMovie, responseCast, true, prefix);
        } catch (er) {
          _moveToDetail(context, null, null, false, prefix);
        }
      });
      await _appDb.closeDb();
    }
  }

  String get baseUrlImage => _liveStore.baseUrlImage;

  String mainCategory() => _liveStore.categories[0];
}

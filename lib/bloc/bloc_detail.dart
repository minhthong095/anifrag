import 'package:Anifrag/model/responses/response_cast.dart';
import 'package:Anifrag/model/responses/response_home_page_movie.dart';
import 'package:Anifrag/model/responses/response_movie.dart';
import 'package:Anifrag/network/apis.dart';
import 'package:Anifrag/store/live_store.dart';
import 'package:Anifrag/store/offline/offline_movie.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/subjects.dart';

class BlocDetail {
  final OfflineMovie _offlineMovie;
  final LiveStore _liveStore;
  final AbsAPI _api;

  ResponseMovie movie;
  List<ResponseCast> casts;
  String tagPrefix;
  PublishSubject subjectMoreLikeThis =
      PublishSubject<List<ResponseThumbnailMovie>>();

  BlocDetail(this._offlineMovie, this._liveStore, this._api) {
    print("YOU R ");
  }

  String currentPosterPath() =>
      _liveStore.responseConfiguration.images.secureBaseUrl + movie.posterPath;

  String baseUrlImg() => _liveStore.responseConfiguration.images.secureBaseUrl;

  void callMoreLikeThis() {
    _api.getMoreLikeThis(movie.id).then((onValue) {
      subjectMoreLikeThis.sink.add(onValue);
    });
  }

  void dipose() {
    subjectMoreLikeThis.close();
  }
}

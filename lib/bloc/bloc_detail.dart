import 'dart:ffi';

import 'package:Anifrag/bloc/dispose_bag.dart';
import 'package:Anifrag/bloc/mixin/prefix_url_mixin.dart';
import 'package:Anifrag/di/component.dart';
import 'package:Anifrag/di/module/module_store.dart';
import 'package:Anifrag/model/responses/response_cast.dart';
import 'package:Anifrag/model/responses/response_home_page_movie.dart';
import 'package:Anifrag/model/responses/response_movie.dart';
import 'package:Anifrag/model/responses/response_movie.dart';
import 'package:Anifrag/network/apis.dart';
import 'package:Anifrag/store/live_store.dart';
import 'package:Anifrag/store/offline/offline_movie.dart';
import 'package:Anifrag/ui/screen/detail.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

@provide
class BlocDetail with DisposeBag {
  final String baseUrlImage;
  // final OfflineMovie _offlineMovie;
  final LiveStore _liveStore;
  final API _api;
  bool _isRunFirstTime = true;

  BlocDetail(this._liveStore, this._api, @baseUrlImg this.baseUrlImage) {
    dropStream(_subjectCallFinishTransition);
  }

  static BlocDetail initWithData(
          {@required BlocDetail blocDetailModule,
          DetailScreenArgument argument}) =>
      blocDetailModule
        ..setMovie = argument.movie
        .._tagPrefix = argument.tagPrefix
        ..setCasts = argument.casts;

  ResponseMovie _movie;
  ResponseMovie get getMovie => _movie;
  set setMovie(ResponseMovie movie) => _movie = movie;
  List<ResponseCast> _casts;
  List<ResponseCast> get getCasts => _casts;
  set setCasts(List<ResponseCast> value) => _casts = value;
  String _tagPrefix;

  String get tagImg {
    return _tagPrefix + _movie.posterPath;
  }

  String get pathImg {
    return _liveStore.baseUrlImage + _movie.posterPath;
  }

  // ignore: close_sinks
  BehaviorSubject<bool> _subjectCallFinishTransition =
      BehaviorSubject.seeded(false);

  void Function(List<ResponseThumbnailMovie>) _callbackDoneMoreLikeThis;
  set setCallbackDoneMoreLikeThis(
      void Function(List<ResponseThumbnailMovie> moreLikeThis) callback) {
    _callbackDoneMoreLikeThis = callback;
  }

  String get currentPosterPath =>
      _liveStore.getResponseConfiguration.images.secureBaseUrl +
      _movie.posterPath;

  void callMoreLikeThis() {
    if (_isRunFirstTime)
      dropSubscription(Stream.fromFuture(_api.getMoreLikeThis(_movie.id))
          .where((data) {
        return (_isRunFirstTime &&
            _callbackDoneMoreLikeThis != null &&
            data != null &&
            data.length > 0);
      }).zipWith<bool, void>(_subjectCallFinishTransition,
              (moreLikeThis, isFinishTransition) async {
        _isRunFirstTime = false;
        await Future.delayed(Duration(milliseconds: 300));
        _callbackDoneMoreLikeThis(moreLikeThis);
      }).listen((voidCallback) {}));
  }

  void callFinishTransition() {
    _subjectCallFinishTransition.sink.add(true);
  }

  // PublishSubject subjectMoreLikeThis =
  //     PublishSubject<List<ResponseThumbnailMovie>>();
  //  _api.getMoreLikeThis(__movie.id).then((onValue) {
  //       subjectMoreLikeThis.sink.add(onValue);
  //     });
}

import 'dart:async';
import 'dart:typed_data';

import 'package:Anifrag/bloc/dispose_bag.dart';
import 'package:Anifrag/model/responses/response_movie.dart';
import 'package:Anifrag/network/apis.dart';
import 'package:Anifrag/store/live_store.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

enum SearchDetailState { standby, error, done }

@provide
class BlocSearchDetail with DisposeBag {
  final API _api;
  final LiveStore _liveStore;
  final _streamTriggerImgDone = StreamController<ResponseMovie>();
  final ValueNotifier<Tuple3<SearchDetailState, ResponseMovie, ImageProvider>>
      stateNotifyDetail =
      ValueNotifier(Tuple3(SearchDetailState.standby, null, null));
  final ValueNotifier<bool> stateLoading = ValueNotifier(false);
  int _idMovie;
  String get baseUrlImage => _liveStore.baseUrlImageWithWidth('/w500');

  BlocSearchDetail(this._api, this._liveStore) {
    dropNotifier(stateLoading);
  }

  void triggerDoneLoadPoster() {
    if (!_streamTriggerImgDone.isClosed) {
      _streamTriggerImgDone.add(null);
      _streamTriggerImgDone.close();
    }
  }

  void callGetDetail(int idMovie) async {
    if (idMovie != _idMovie) {
      stateLoading.value = true;
      try {
        final ResponseMovie movie = await _api.getMovieDetail(idMovie);
        if (movie.posterPath != null && movie.posterPath.isNotEmpty) {
          final imgByte = await Dio().get<List<int>>(
              baseUrlImage + movie.posterPath,
              options: Options(responseType: ResponseType.bytes));

          stateNotifyDetail.value = Tuple3(SearchDetailState.done, movie,
              MemoryImage(Uint8List.fromList(imgByte.data)));
        } else {
          stateNotifyDetail.value = Tuple3(SearchDetailState.done, movie, null);
        }
        _idMovie = idMovie;
      } catch (er) {
        stateNotifyDetail.value = Tuple3(SearchDetailState.error, null, null);
      } finally {
        stateLoading.value = false;
      }
    }
  }
}

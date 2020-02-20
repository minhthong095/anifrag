import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:Anifrag/bloc/dispose_bag.dart';
import 'package:Anifrag/di/component.dart';
import 'package:Anifrag/model/responses/response_movie.dart';
import 'package:Anifrag/model/responses/response_search.dart';
import 'package:Anifrag/network/apis.dart';
import 'package:Anifrag/store/live_store.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

import 'mixin/prefix_url_mixin.dart';

enum SearchDetailState { standby, error, done }

@provide
class BlocSearchDetail with DisposeBag {
  final API _api;
  final LiveStore _liveStore;
  final streamTriggerImgDone = StreamController<ResponseMovie>();

  int _idMovie;

  final ValueNotifier<Tuple3<SearchDetailState, ResponseMovie, ImageProvider>>
      notifyDetailState =
      ValueNotifier(Tuple3(SearchDetailState.standby, null, null));
  final ValueNotifier<bool> notifyIsLoading = ValueNotifier(false);

  String get baseUrlImage => _liveStore.baseUrlImageWithWidth('/w500');

  BlocSearchDetail(this._api, this._liveStore) {
    dropNotifier(notifyIsLoading);
  }

  void triggerDoneLoadPoster() {
    if (!streamTriggerImgDone.isClosed) {
      streamTriggerImgDone.add(null);
      streamTriggerImgDone.close();
    }
  }

  void callGetDetail(int idMovie) async {
    if (idMovie != _idMovie) {
      notifyIsLoading.value = true;
      try {
        final ResponseMovie movie = await _api.getMovieDetail(idMovie);
        if (movie.posterPath != null && movie.posterPath.isNotEmpty) {
          final imgByte = await Dio().get<List<int>>(
              baseUrlImage + movie.posterPath,
              options: Options(responseType: ResponseType.bytes));

          notifyDetailState.value = Tuple3(SearchDetailState.done, movie,
              MemoryImage(Uint8List.fromList(imgByte.data)));
        } else {
          notifyDetailState.value = Tuple3(SearchDetailState.done, movie, null);
        }
        _idMovie = idMovie;
      } catch (er) {
        notifyDetailState.value = Tuple3(SearchDetailState.error, null, null);
      } finally {
        notifyIsLoading.value = false;
      }
    }
  }
}

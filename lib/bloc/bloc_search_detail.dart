import 'package:Anifrag/bloc/dispose_bag.dart';
import 'package:Anifrag/model/responses/response_movie.dart';
import 'package:Anifrag/model/responses/response_search.dart';
import 'package:Anifrag/network/apis.dart';
import 'package:Anifrag/store/live_store.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum SearchDetailState { standby, error, done }

class BlocSearchDetail extends DisposeBag {
  final API _api;
  final LiveStore _liveStore;

  bool _isAlreadyInit = false;
  bool get isAlreadyInit => _isAlreadyInit;

  final ValueNotifier<Tuple2<SearchDetailState, ResponseMovie>>
      notifyDetailState =
      ValueNotifier(Tuple2(SearchDetailState.standby, null));
  final ValueNotifier<bool> notifyIsLoading = ValueNotifier(false);

  int _idMovie;
  get getIdMovie => _idMovie;
  set setIdMovie(int value) => _idMovie = value;

  BlocSearchDetail(this._api, this._liveStore) {
    dropNotifier(notifyIsLoading);
  }

  String get baseUrlImage => _liveStore.baseUrlImage;

  void callGetDetail() async {
    _isAlreadyInit = true;
    notifyIsLoading.value = true;
    try {
      final ResponseMovie movie = await _api.getMovieDetail(_idMovie);
      notifyDetailState.value = Tuple2(SearchDetailState.done, movie);
    } catch (er) {
      notifyDetailState.value = Tuple2(SearchDetailState.error, null);
    } finally {
      notifyIsLoading.value = false;
    }
  }
}

import 'dart:collection';

import 'package:Anifrag/bloc/dispose_bag.dart';
import 'package:Anifrag/model/responses/response_search.dart';
import 'package:Anifrag/network/apis.dart';
import 'package:Anifrag/store/live_store.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

enum SearchState { fulfill, empty, kickoff }

class BlocSearchView extends DisposeBag {
  final API _api;
  final LiveStore _liveStore;
  final observable = PublishSubject<String>();
  final ValueNotifier<bool> valueNotifyIsLoading = ValueNotifier(false);

  final subjectSearchState =
      PublishSubject<Tuple2<SearchState, List<ResponseSearch>>>();

  String latestKeyword = '';

  BlocSearchView(this._api, this._liveStore) {
    dropSubscription(observable
        .where((String keyword) => keyword != '')
        .map((String keywrod) => keywrod.trim().replaceAll(RegExp(' +'), ' '))
        .doOnData((String keyword) {
          latestKeyword = keyword;
          valueNotifyIsLoading.value = true;
          final searchHistory = _liveStore.getSearchHistory[keyword];
          if (searchHistory != null) {
            subjectSearchState.sink.add(Tuple2(
                searchHistory.length > 0
                    ? SearchState.fulfill
                    : SearchState.empty,
                _liveStore.getSearchHistory[keyword]));
          }
        })
        .where((String keyword) => _liveStore.getSearchHistory[keyword] == null)
        .flatMap((String keyword) =>
            Observable.fromFuture(_api.searchMovies(keyword)))
        .listen((HashMap<String, List<ResponseSearch>> response) {
          _liveStore.getSearchHistory
              .putIfAbsent(response.keys.first, () => response.values.first);

          if (latestKeyword == response.keys.first) {
            if (response.values.first == null ||
                response.values.first.length == 0)
              subjectSearchState.sink.add(Tuple2(SearchState.empty, []));
            else
              subjectSearchState.sink.add(Tuple2(SearchState.fulfill,
                  _liveStore.getSearchHistory[latestKeyword]));
          }
        }));

    dropSubscription(subjectSearchState.listen((searchState) {
      valueNotifyIsLoading.value = false;
    }));

    dropNotifier(valueNotifyIsLoading);
  }

  void searchMovies(String keyword) async {
    observable.add(keyword);
  }

  String get getBaseUrlImage => _liveStore.baseUrlImage;
}

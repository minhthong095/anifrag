import 'dart:collection';

import 'package:Anifrag/bloc/dispose_bag.dart';
import 'package:Anifrag/di/module/module_store.dart';
import 'package:Anifrag/model/responses/response_search.dart';
import 'package:Anifrag/network/apis.dart';
import 'package:Anifrag/store/live_store.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

enum SearchState { fulfill, empty, kickoff }

@provide
class BlocSearchView with DisposeBag {
  final API _api;
  final LiveStore _liveStore;
  final String baseUrlImage;
  final _observable = PublishSubject<String>();
  final ValueNotifier<bool> stateLoading = ValueNotifier(false);
  final stateSearch =
      PublishSubject<Tuple2<SearchState, List<ResponseSearch>>>();
  String latestKeyword = '';

  BlocSearchView(this._api, this._liveStore, @baseUrlImg this.baseUrlImage) {
    dropSubscription(_observable
        .doOnData((keyword) {
          if (keyword == '')
            stateSearch.sink.add(Tuple2(SearchState.kickoff, null));
        })
        .where((String keyword) => keyword != '')
        .map((String keywrod) => keywrod.trim().replaceAll(RegExp(' +'), ' '))
        .doOnData((String keyword) {
          latestKeyword = keyword;
          stateLoading.value = true;
          final searchHistory = _liveStore.getSearchHistory[keyword];
          if (searchHistory != null) {
            stateSearch.sink.add(Tuple2(
                searchHistory.length > 0
                    ? SearchState.fulfill
                    : SearchState.empty,
                _liveStore.getSearchHistory[keyword]));
          }
        })
        .where((String keyword) => _liveStore.getSearchHistory[keyword] == null)
        .flatMap(
            (String keyword) => Stream.fromFuture(_api.searchMovies(keyword)))
        .listen((HashMap<String, List<ResponseSearch>> response) {
          _liveStore.getSearchHistory
              .putIfAbsent(response.keys.first, () => response.values.first);

          if (latestKeyword == response.keys.first) {
            if (response.values.first == null ||
                response.values.first.length == 0)
              stateSearch.sink.add(Tuple2(SearchState.empty, null));
            else
              stateSearch.sink.add(Tuple2(SearchState.fulfill,
                  _liveStore.getSearchHistory[latestKeyword]));
          }
        }));

    dropSubscription(stateSearch.listen((searchState) {
      stateLoading.value = false;
    }));

    dropNotifier(stateLoading);
  }

  void searchMovies(String keyword) async {
    _observable.add(keyword);
  }
}

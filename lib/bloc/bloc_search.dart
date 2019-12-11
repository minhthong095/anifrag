import 'dart:collection';

import 'package:Anifrag/bloc/dispose_bag.dart';
import 'package:Anifrag/model/responses/response_search.dart';
import 'package:Anifrag/network/apis.dart';
import 'package:Anifrag/store/live_store.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

enum SearchState { fulfill, empty, kickoff }

class BlocSearch extends DisposeBag {
  final API _api;
  final LiveStore _liveStore;
  final observable = PublishSubject<String>();
  final ValueNotifier<bool> valueNotifyIsLoading = ValueNotifier(false);

  final subjectSearchState = BehaviorSubject.seeded(SearchState.kickoff);

  String latestKeyword = '';

  BlocSearch(this._api, this._liveStore) {
    dropSubscription(observable
        .where((String keyword) => keyword != '')
        .map((String keywrod) => keywrod.trim().replaceAll(RegExp(' +'), ' '))
        .doOnData((String keyword) {
          latestKeyword = keyword;
          valueNotifyIsLoading.value = true;
          if (_liveStore.getSearchHistory[keyword] != null) {
            subjectSearchState.sink.add(SearchState.fulfill);
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
              subjectSearchState.sink.add(SearchState.empty);
            else
              subjectSearchState.sink.add(SearchState.fulfill);
          }
        }));

    dropSubscription(subjectSearchState.listen((searchState) {
      valueNotifyIsLoading.value = false;
    }));
  }

  void searchMovies(String keyword) async {
    observable.add(keyword);
  }

  @override
  void dispose() {
    super.dispose();
    valueNotifyIsLoading.dispose();
  }
}

import 'dart:ffi';

import 'package:Anifrag/bloc/dispose_bag.dart';
import 'package:Anifrag/model/responses/response_cast.dart';
import 'package:Anifrag/model/responses/response_home_page_movie.dart';
import 'package:Anifrag/model/responses/response_movie.dart';
import 'package:Anifrag/network/apis.dart';
import 'package:Anifrag/store/live_store.dart';
import 'package:Anifrag/store/offline/offline_movie.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class BlocDetail extends DisposeBag {
  final OfflineMovie _offlineMovie;
  final LiveStore _liveStore;
  final API _api;
  bool _isRunFirstTime = true;

  ResponseMovie _movie;
  void setMovie(movie) => _movie = movie;
  get getMovie => _movie;

  List<ResponseCast> _casts;
  void setCasts(casts) => _casts = casts;
  get getCasts => _casts;

  String _tagPrefix;
  void setTagPrefix(tagPrefix) => _tagPrefix = tagPrefix;
  get getTagPrefix => _tagPrefix;

  // Stream<void> streamCallFinishTransition() async* {
  //   yield null;
  // }

  BehaviorSubject<bool> _subjectCallFinishTransition =
      BehaviorSubject.seeded(false);

  void Function(List<ResponseThumbnailMovie>) _callbackDoneMoreLikeThis;
  set setCallbackDoneMoreLikeThis(
      void Function(List<ResponseThumbnailMovie> moreLikeThis) callback) {
    _callbackDoneMoreLikeThis = callback;
  }

  BlocDetail(this._offlineMovie, this._liveStore, this._api) {
    dropStream(_subjectCallFinishTransition);
  }

  String get currentPosterPath =>
      _liveStore.responseConfiguration.images.secureBaseUrl + _movie.posterPath;

  String get baseUrlImage => _liveStore.baseUrlImage;

  void callMoreLikeThis() {
    if (_isRunFirstTime)
      dropSubscription(Observable.fromFuture(_api.getMoreLikeThis(_movie.id))
          .where((data) {
        return (_isRunFirstTime &&
            _callbackDoneMoreLikeThis != null &&
            data != null &&
            data.length > 0);
      }).zipWith<bool, void>(_subjectCallFinishTransition,
              (moreLikeThis, isFinishTransition) async {
        _isRunFirstTime = false;
        print("HIHI");
        await Future.delayed(Duration(milliseconds: 300));
        _callbackDoneMoreLikeThis(moreLikeThis);
      }).listen((voidCallback) {}));
  }

  void callFinishTransition() {
    _subjectCallFinishTransition.sink.add(true);
  }

  // PublishSubject subjectMoreLikeThis =
  //     PublishSubject<List<ResponseThumbnailMovie>>();
  //  _api.getMoreLikeThis(_movie.id).then((onValue) {
  //       subjectMoreLikeThis.sink.add(onValue);
  //     });
}

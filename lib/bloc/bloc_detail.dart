import 'package:Anifrag/bloc/dispose_bag.dart';
import 'package:Anifrag/di/module/module_store.dart';
import 'package:Anifrag/model/business/business_movie.dart';
import 'package:Anifrag/model/responses/response_cast.dart';
import 'package:Anifrag/model/responses/response_home_page_movie.dart';
import 'package:Anifrag/network/apis.dart';
import 'package:Anifrag/state/state_detail_episode.dart';
import 'package:Anifrag/store/live_store.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

@provide
class BlocDetail with DisposeBag {
  final String baseUrlImage;
  final LiveStore _liveStore;
  final API _api;
  // ignore: close_sinks
  final BehaviorSubject stateEpisode =
      BehaviorSubject.seeded(StateDetailEpisode.empty());
  bool _isRunFirstTime = true;
  BusinessMovie _movie;
  BusinessMovie get getMovie => _movie;
  List<ResponseCast> _casts;
  List<ResponseCast> get getCasts => _casts;
  String _tagPrefix;
  String get tagImg => _tagPrefix + _movie.posterPath;
  String get pathImg => _liveStore.baseUrlImage + _movie.posterPath;

  Function(List<ResponseThumbnailMovie>) _callbackDoneMoreLikeThis;
  // ignore: close_sinks
  BehaviorSubject<bool> _subjectCallFinishTransition =
      BehaviorSubject.seeded(false);
  set setCallbackDoneMoreLikeThis(
      void Function(List<ResponseThumbnailMovie> moreLikeThis) callback) {
    _callbackDoneMoreLikeThis = callback;
  }

  String get currentPosterPath =>
      _liveStore.getResponseConfiguration.images.secureBaseUrl +
      _movie.posterPath;

  static BlocDetail initWithData(BlocDetail blocDetailModule,
          BusinessMovie movie, String tagPrefix, List<ResponseCast> cast) =>
      blocDetailModule
        .._movie = movie
        .._tagPrefix = tagPrefix
        .._casts = cast;

  BlocDetail(this._liveStore, this._api, @baseUrlImg this.baseUrlImage) {
    dropStream(_subjectCallFinishTransition);
    dropStream(stateEpisode);
  }

  void callEpisodes() {}

  void callMoreLikeThis() {
    if (_isRunFirstTime &&
        _movie.numberOfSeasons == -1) // equal -1 mean it is not tv series
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

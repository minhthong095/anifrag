import 'package:Anifrag/model/responses/response_tv_episode.dart';
import 'package:sealed_unions/sealed_unions.dart';

class StateDetailEpisode
    extends Union3Impl<StateInitial, StateEmpty, StateLoaded> {
  static final factory = Triplet<StateInitial, StateEmpty, StateLoaded>();

  StateDetailEpisode._(Union3<StateInitial, StateEmpty, StateLoaded> union)
      : super(union);

  factory StateDetailEpisode.initial() =>
      StateDetailEpisode._(factory.first(StateInitial()));

  factory StateDetailEpisode.empty() =>
      StateDetailEpisode._(factory.second(StateEmpty()));

  factory StateDetailEpisode.loaded(List<ResponseTvEpisode> data) =>
      StateDetailEpisode._(factory.third(StateLoaded(data)));
}

class StateInitial {}

class StateEmpty {}

class StateLoaded {
  final List<ResponseTvEpisode> data;
  StateLoaded(this.data);
}

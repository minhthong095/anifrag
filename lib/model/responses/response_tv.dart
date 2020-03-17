import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_tv.g.dart';

/// Combine both Movie and TV
@JsonSerializable()
class ResponseTv {
  final int id;
  final String overview;
  @JsonKey(name: 'episode_run_time')
  final List<int> episodeRunTime;
  final double popularity;
  @JsonKey(name: 'original_name')
  final String originalName;
  @JsonKey(name: 'poster_path')
  final String posterPath;
  @JsonKey(name: 'first_air_date')
  final DateTime firstAirDate;
  @JsonKey(name: 'vote_average')
  final double voteAverage;
  @JsonKey(name: 'vote_count')
  final int voteCount;
  @JsonKey(name: 'number_of_seasons')
  final int numberOfSeasons;
  @JsonKey(name: 'number_of_episodes')
  final int numberOfEpisodes;

  ResponseTv(
      {@required this.id,
      @required this.originalName,
      @required this.posterPath,
      @required this.overview,
      @required this.episodeRunTime,
      @required this.firstAirDate,
      @required this.voteAverage,
      @required this.popularity,
      @required this.voteCount,
      @required this.numberOfSeasons,
      @required this.numberOfEpisodes});

  factory ResponseTv.fromJson(Map<String, dynamic> json) {
    return _$ResponseTvFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ResponseTvToJson(this);
}

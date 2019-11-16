import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_movie.g.dart';

@JsonSerializable()
class ResponseMovie {
  final int id;
  final String overview;
  final int runtime;
  final double popularity;
  final String title;

  @JsonKey(name: 'poster_path')
  final String posterPath;

  @JsonKey(name: 'release_date')
  final DateTime releaseDate;

  @JsonKey(name: 'vote_average')
  final double voteAverage;

  @JsonKey(name: 'vote_count')
  final int voteCount;

  ResponseMovie(
      {@required this.id,
      @required this.title,
      @required this.posterPath,
      @required this.overview,
      @required this.runtime,
      @required this.releaseDate,
      @required this.voteAverage,
      @required this.popularity,
      @required this.voteCount});

  factory ResponseMovie.fromJson(Map<String, dynamic> json) =>
      _$ResponseMovieFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseMovieToJson(this);
}

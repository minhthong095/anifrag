import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_home_page_movie.g.dart';

// @JsonSerializable()
class ResponseHomePageMovie {
  final int id;

  // @JsonKey(name: 'poster_path')
  final String posterPath;

  ResponseHomePageMovie({@required this.id, @required this.posterPath});

  factory ResponseHomePageMovie.fromJson(Map<String, dynamic> json) =>
      _$ResponseHomePageMovieFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseHomePageMovieToJson(this);
}

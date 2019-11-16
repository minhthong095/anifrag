import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_home_page_movie.g.dart';

// @JsonSerializable()
class ResponseThumbnailMovie {
  final int id;

  // @JsonKey(name: 'poster_path')
  final String posterPath;

  ResponseThumbnailMovie({@required this.id, @required this.posterPath});

  factory ResponseThumbnailMovie.fromJson(Map<String, dynamic> json) =>
      _$ResponseThumbnailMovieFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseThumbnailMovieToJson(this);
}

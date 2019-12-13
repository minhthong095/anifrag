import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_search.g.dart';

@JsonSerializable()
class ResponseSearch {
  final int id;

  @JsonKey(name: 'original_title', defaultValue: '')
  final String originalTitle;

  @JsonKey(name: 'poster_path', defaultValue: '')
  final String posterPath;

  @JsonKey(name: 'release_date')
  final DateTime releaseDate;

  @JsonKey(name: 'vote_count', defaultValue: 0)
  final int runtime;

  @JsonKey(name: 'popularity', defaultValue: 0)
  final double popularity;

  ResponseSearch(
      {@required this.id,
      @required this.originalTitle,
      @required this.posterPath,
      @required this.releaseDate,
      @required this.popularity,
      @required this.runtime});

  factory ResponseSearch.fromJson(Map<String, dynamic> json) {
    if (json['release_date'] == '') {
      json['release_date'] = null;
    }
    return _$ResponseSearchFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ResponseSearchToJson(this);
}

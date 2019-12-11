// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseSearch _$ResponseSearchFromJson(Map<String, dynamic> json) {
  return ResponseSearch(
    id: json['id'] as int,
    originalTitle: json['original_title'] as String,
    runtime: json['vote_count'] as int,
    releaseDate: json['release_date'] == null || json['release_date'] == ''
        ? null
        : DateTime.parse(json['release_date'] as String),
    posterPath: json['poster_path'] as String,
    popularity: (json['popularity'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$ResponseSearchToJson(ResponseSearch instance) =>
    <String, dynamic>{
      'id': instance.id,
      'runtime': instance.runtime,
      'popularity': instance.popularity,
      'poster_path': instance.posterPath,
      'release_date': instance.releaseDate?.toIso8601String(),
    };

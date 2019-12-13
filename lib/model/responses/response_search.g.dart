// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseSearch _$ResponseSearchFromJson(Map<String, dynamic> json) {
  return ResponseSearch(
    id: json['id'] as int,
    originalTitle: json['original_title'] as String ?? '',
    posterPath: json['poster_path'] as String ?? '',
    releaseDate: json['release_date'] == null
        ? null
        : DateTime.parse(json['release_date'] as String),
    popularity: (json['popularity'] as num)?.toDouble() ?? 0,
    runtime: json['vote_count'] as int ?? 0,
  );
}

Map<String, dynamic> _$ResponseSearchToJson(ResponseSearch instance) =>
    <String, dynamic>{
      'id': instance.id,
      'original_title': instance.originalTitle,
      'poster_path': instance.posterPath,
      'release_date': instance.releaseDate?.toIso8601String(),
      'vote_count': instance.runtime,
      'popularity': instance.popularity,
    };

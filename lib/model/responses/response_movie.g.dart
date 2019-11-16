// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseMovie _$ResponseMovieFromJson(Map<String, dynamic> json) {
  return ResponseMovie(
    id: json['id'] as int,
    title: json['title'] as String,
    overview: json['overview'] as String,
    runtime: json['runtime'] as int,
    releaseDate: json['release_date'] == null
        ? null
        : DateTime.parse(json['release_date'] as String),
    posterPath: json['poster_path'] as String,
    voteAverage: (json['vote_average'] as num)?.toDouble(),
    popularity: (json['popularity'] as num)?.toDouble(),
    voteCount: json['vote_count'] as int,
  );
}

Map<String, dynamic> _$ResponseMovieToJson(ResponseMovie instance) =>
    <String, dynamic>{
      'id': instance.id,
      'overview': instance.overview,
      'runtime': instance.runtime,
      'popularity': instance.popularity,
      'title': instance.title,
      'poster_path': instance.posterPath,
      'release_date': instance.releaseDate?.toIso8601String(),
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
    };

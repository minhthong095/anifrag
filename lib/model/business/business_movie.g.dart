// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessMovie _$BusinessMovieFromJson(Map<String, dynamic> json) {
  return BusinessMovie(
    json['id'] as int,
    json['overview'] as String,
    (json['popularity'] as num)?.toDouble(),
    json['runtime'] as int,
    json['title'] as String,
    json['poster_path'] as String,
    json['release_date'] == null
        ? null
        : DateTime.parse(json['release_date'] as String),
    (json['vote_average'] as num)?.toDouble(),
    json['number_of_episodes'] as int,
    json['number_of_seasons'] as int,
    json['vote_count'] as int,
  );
}

Map<String, dynamic> _$BusinessMovieToJson(BusinessMovie instance) =>
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
      'number_of_seasons': instance.numberOfSeasons,
      'number_of_episodes': instance.numberOfEpisodes,
    };

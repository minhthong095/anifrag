// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_tv.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseTv _$ResponseTvFromJson(Map<String, dynamic> json) {
  return ResponseTv(
    id: json['id'] as int,
    originalName: json['original_name'] as String,
    posterPath: json['poster_path'] as String,
    overview: json['overview'] as String,
    episodeRunTime:
        (json['episode_run_time'] as List)?.map((e) => e as int)?.toList(),
    firstAirDate: json['first_air_date'] == null
        ? null
        : DateTime.parse(json['first_air_date'] as String),
    voteAverage: (json['vote_average'] as num)?.toDouble(),
    popularity: (json['popularity'] as num)?.toDouble(),
    voteCount: json['vote_count'] as int,
    numberOfSeasons: json['number_of_seasons'] as int,
    numberOfEpisodes: json['number_of_episodes'] as int,
  );
}

Map<String, dynamic> _$ResponseTvToJson(ResponseTv instance) =>
    <String, dynamic>{
      'id': instance.id,
      'overview': instance.overview,
      'episode_run_time': instance.episodeRunTime,
      'popularity': instance.popularity,
      'original_name': instance.originalName,
      'poster_path': instance.posterPath,
      'first_air_date': instance.firstAirDate?.toIso8601String(),
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'number_of_seasons': instance.numberOfSeasons,
      'number_of_episodes': instance.numberOfEpisodes,
    };

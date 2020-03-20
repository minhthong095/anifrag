// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_tv_episode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseTvEpisode _$ResponseTvEpisodeFromJson(Map<String, dynamic> json) {
  return ResponseTvEpisode(
    json['episode_number'] as int,
    json['name'] as String,
    _fromJson(json['air_date'] as String),
  );
}

Map<String, dynamic> _$ResponseTvEpisodeToJson(ResponseTvEpisode instance) =>
    <String, dynamic>{
      'episode_number': instance.episodeNumber,
      'name': instance.name,
      'air_date': _toJson(instance.airDate),
    };

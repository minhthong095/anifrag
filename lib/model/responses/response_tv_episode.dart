import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_tv_episode.g.dart';

/// Combine both Movie and TV
@JsonSerializable()
class ResponseTvEpisode {
  @JsonKey(name: 'episode_number')
  final int episodeNumber;
  final String name;
  @JsonKey(name: 'air_date', fromJson: _fromJson, toJson: _toJson)
  final DateTime airDate;
  ResponseTvEpisode(this.episodeNumber, this.name, this.airDate);

  factory ResponseTvEpisode.fromJson(Map<String, dynamic> json) {
    return _$ResponseTvEpisodeFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ResponseTvEpisodeToJson(this);
}

_fromJson(String airDate) => DateFormat('yyyy-MM-dd').parse(airDate);
_toJson(DateTime airDate) => DateFormat('yyyy-MM-dd').format(airDate);

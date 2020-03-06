import 'package:json_annotation/json_annotation.dart';

part 'response_configuration.g.dart';

@JsonSerializable()
class ResponseConfiguration {
  final ResponseConfigurationImages images;

  @JsonKey(name: 'change_keys')
  final List<String> changeKeys;

  ResponseConfiguration({this.images, this.changeKeys});

  factory ResponseConfiguration.fromJson(Map<String, dynamic> json) =>
      _$ResponseConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseConfigurationToJson(this);
}

@JsonSerializable()
class ResponseConfigurationImages {
  @JsonKey(name: 'poster_sizes')
  final List<String> posterSizes;

  @JsonKey(name: 'secure_base_url')
  final String secureBaseUrl;

  ResponseConfigurationImages({this.posterSizes, this.secureBaseUrl});

  factory ResponseConfigurationImages.fromJson(Map<String, dynamic> json) =>
      _$ResponseConfigurationImagesFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseConfigurationImagesToJson(this);
}

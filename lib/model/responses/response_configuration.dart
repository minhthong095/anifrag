part 'response_configuration.g.dart';

// @JsonSerializable()
class ResponseConfiguration {
  final ModelConfigurationImages images;

  // @JsonKey(name: 'secure_base_url')
  final String secureBaseUrl;

  // @JsonKey(name: 'change_keys')
  final List<String> changeKeys;

  ResponseConfiguration({this.images, this.changeKeys, this.secureBaseUrl});

  factory ResponseConfiguration.fromJson(Map<String, dynamic> json) =>
      _$ResponseConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$ModelConfigurationToJson(this);
}

// @JsonSerializ able()
class ModelConfigurationImages {
  // @JsonKey(name: 'poster_sizes')
  final List<String> posterSizes;

  ModelConfigurationImages({this.posterSizes});

  factory ModelConfigurationImages.fromJson(Map<String, dynamic> json) =>
      _$ResponseConfigurationImagesFromJson(json);
  Map<String, dynamic> toJson() => _$ModelConfigurationImagesToJson(this);
}

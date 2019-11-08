part 'model_configuration.g.dart';

// @JsonSerializable()
class ModelConfiguration {
  final ModelConfigurationImages images;

  // @JsonKey(name: 'secure_base_url')
  final String secureBaseUrl;

  // @JsonKey(name: 'change_keys')
  final List<String> changeKeys;

  ModelConfiguration({this.images, this.changeKeys, this.secureBaseUrl});

  factory ModelConfiguration.fromJson(Map<String, dynamic> json) =>
      _$ModelConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$ModelConfigurationToJson(this);
}

// @JsonSerializ able()
class ModelConfigurationImages {
  // @JsonKey(name: 'poster_sizes')
  final List<String> posterSizes;

  ModelConfigurationImages({this.posterSizes});

  factory ModelConfigurationImages.fromJson(Map<String, dynamic> json) =>
      _$ModelConfigurationImagesFromJson(json);
  Map<String, dynamic> toJson() => _$ModelConfigurationImagesToJson(this);
}

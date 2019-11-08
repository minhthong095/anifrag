// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelConfiguration _$ModelConfigurationFromJson(Map<String, dynamic> json) {
  return ModelConfiguration(
    images: json['images'] == null
        ? null
        : ModelConfigurationImages.fromJson(
            json['images'] as Map<String, dynamic>),
    changeKeys:
        (json['change_keys'] as List)?.map((e) => e as String)?.toList(),
    secureBaseUrl: json['secure_base_url'] as String,
  );
}

Map<String, dynamic> _$ModelConfigurationToJson(ModelConfiguration instance) =>
    <String, dynamic>{
      'images': instance.images,
      'secure_base_url': instance.secureBaseUrl,
      'change_keys': instance.changeKeys,
    };

ModelConfigurationImages _$ModelConfigurationImagesFromJson(
    Map<String, dynamic> json) {
  return ModelConfigurationImages(
    posterSizes:
        (json['poster_sizes'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$ModelConfigurationImagesToJson(
        ModelConfigurationImages instance) =>
    <String, dynamic>{
      'poster_sizes': instance.posterSizes,
    };

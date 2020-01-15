// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseConfiguration _$ResponseConfigurationFromJson(
    Map<String, dynamic> json) {
  return ResponseConfiguration(
    images: json['images'] == null
        ? null
        : ResponseConfigurationImages.fromJson(
            json['images'] as Map<String, dynamic>),
    changeKeys:
        (json['change_keys'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$ResponseConfigurationToJson(
        ResponseConfiguration instance) =>
    <String, dynamic>{
      'images': instance.images,
      'change_keys': instance.changeKeys,
    };

ResponseConfigurationImages _$ResponseConfigurationImagesFromJson(
    Map<String, dynamic> json) {
  return ResponseConfigurationImages(
    posterSizes:
        (json['poster_sizes'] as List)?.map((e) => e as String)?.toList(),
    secureBaseUrl: json['secure_base_url'] as String,
  );
}

Map<String, dynamic> _$ResponseConfigurationImagesToJson(
        ResponseConfigurationImages instance) =>
    <String, dynamic>{
      'poster_sizes': instance.posterSizes,
      'secure_base_url': instance.secureBaseUrl,
    };

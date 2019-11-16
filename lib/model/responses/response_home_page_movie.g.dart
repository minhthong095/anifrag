// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_home_page_movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseThumbnailMovie _$ResponseThumbnailMovieFromJson(
    Map<String, dynamic> json) {
  return ResponseThumbnailMovie(
    id: json['id'] as int,
    posterPath: json['poster_path'] as String,
  );
}

Map<String, dynamic> _$ResponseThumbnailMovieToJson(
        ResponseThumbnailMovie instance) =>
    <String, dynamic>{
      'id': instance.id,
      'poster_path': instance.posterPath,
    };

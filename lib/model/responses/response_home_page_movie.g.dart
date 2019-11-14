// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_home_page_movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseHomePageMovie _$ResponseHomePageMovieFromJson(
    Map<String, dynamic> json) {
  return ResponseHomePageMovie(
    id: json['id'] as int,
    posterPath: json['poster_path'] as String,
  );
}

Map<String, dynamic> _$ResponseHomePageMovieToJson(
        ResponseHomePageMovie instance) =>
    <String, dynamic>{
      'id': instance.id,
      'poster_path': instance.posterPath,
    };

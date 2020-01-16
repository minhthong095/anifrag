import 'dart:collection';

import 'package:Anifrag/model/responses/response_cast.dart';
import 'package:Anifrag/model/responses/response_configuration.dart';
import 'package:Anifrag/model/responses/response_home_page_movie.dart';
import 'package:Anifrag/model/responses/response_movie.dart';
import 'package:Anifrag/model/responses/response_search.dart';
import 'package:Anifrag/network/api_key.dart';
import 'package:Anifrag/network/requesting.dart';
import 'package:Anifrag/network/url.dart';
import 'package:dio/dio.dart';
import 'package:inject/inject.dart';

abstract class API {
  Future<ResponseConfiguration> getConfiguration();
  Future<List<String>> getCategories();
  Future<List<ResponseThumbnailMovie>> getHomePageList(int categorySize);
  Future<ResponseMovie> getMovieDetail(int idMovie);
  Future<List<ResponseCast>> getCasts(int idMovie);
  Future<List<ResponseThumbnailMovie>> getMoreLikeThis(int idMovie);
  Future<List<dynamic>> getBothConfigureAndCategory();
  Future<HashMap<String, List<ResponseSearch>>> searchMovies(String keyword);
}

class Api extends API {
  final RequestingMovie _requesting;
  final RequestingAbiary _requestingAbiary;
  final Url _url;

  Api(this._requesting, this._url, this._requestingAbiary);

  Future<HashMap<String, List<ResponseSearch>>> searchMovies(
      String keyword) async {
    if (keyword.length == 0)
      return HashMap<String, List<ResponseSearch>>()
        ..putIfAbsent(keyword, () => []);

    final result = await _requesting.sendGETv3(_url.searchMovies,
        args: {'include_adult': true, 'query': keyword});
    final hashmap = HashMap<String, List<ResponseSearch>>();
    hashmap.putIfAbsent(
        keyword,
        () => ((result.data as Map)['results'] as List)
            .map<ResponseSearch>(
                (movieThumbnail) => ResponseSearch.fromJson(movieThumbnail))
            .toList());
    return hashmap;
  }

  @override
  Future<ResponseConfiguration> getConfiguration() async {
    final result = await _requesting.sendGETv3(_url.configuration);
    return ResponseConfiguration.fromJson(result.data);
  }

  @override
  Future<List<dynamic>> getBothConfigureAndCategory() async {
    final waiting = await Future.wait<Response>([
      _requesting.sendGETv3(_url.configuration),
      _requestingAbiary.sendGET(_url.categories)
    ]);
    return [
      ResponseConfiguration.fromJson((waiting[0].data)),
      (waiting[1].data as Map<String, dynamic>)['categories'].cast<String>()
    ];
  }

  @override
  Future<List<ResponseThumbnailMovie>> getMoreLikeThis(int idMovie) async {
    final result = await _requesting.sendGETv3(_url.moreLikeThis(idMovie));
    return ((result.data as Map)['results'] as List)
        .map<ResponseThumbnailMovie>(
            (movieThumbnail) => ResponseThumbnailMovie.fromJson(movieThumbnail))
        .toList();
  }

  @override
  Future<List<ResponseCast>> getCasts(int idMovie) async {
    final result = await _requesting.sendGETv3(_url.movieCast(idMovie));
    return result.data['cast']
        .map<ResponseCast>((cast) => ResponseCast.fromJson(cast))
        .toList();
  }

  @override
  Future<List<ResponseThumbnailMovie>> getHomePageList(int categorySize) async {
    final result3 = <ResponseThumbnailMovie>[];

    final setToCall2 = Iterable.generate(categorySize, (i) {
      return _requesting.sendGETv3(_url.trending, args: {'page': i * 10 + 1});
    });

    await Future.wait(setToCall2)
      ..forEach((categoryResponse) {
        ((categoryResponse.data as Map)['results'] as List).forEach((movie) {
          result3.add(ResponseThumbnailMovie.fromJson(movie));
        });
      });
    return result3;
  }

  Future<ResponseMovie> getMovieDetail(int idMovie) async {
    final result = await _requesting.sendGETv3(_url.movieDetail(idMovie));
    return ResponseMovie.fromJson(result.data);
  }

  @override
  Future<List<String>> getCategories() async {
    final result = await _requestingAbiary.sendGET(_url.categories);
    final data = result.data as Map<String, dynamic>;
    return data['categories'].cast<String>();
  }
}

import 'package:Anifrag/model/responses/response_cast.dart';
import 'package:Anifrag/model/responses/response_configuration.dart';
import 'package:Anifrag/model/responses/response_home_page_movie.dart';
import 'package:Anifrag/model/responses/response_movie.dart';
import 'package:Anifrag/network/api_key.dart';
import 'package:Anifrag/network/requesting.dart';
import 'package:Anifrag/network/url.dart';
import 'package:inject/inject.dart';

abstract class AbsAPI {
  Future<ResponseConfiguration> getConfiguration();
  Future<List<String>> getCategories();
  Future<List<ResponseHomePageMovie>> getHomePageList(int categorySize);
  Future<ResponseMovie> getMovieDetail(int idMovie);
  Future<List<ResponseCast>> getCasts(int idMovie);
}

class APIs extends AbsAPI {
  final Requesting _requesting;
  final RequestingAbiary _requestingAbiary;
  final AbsUrl _url;

  APIs(this._requesting, this._url, this._requestingAbiary);

  @override
  Future<ResponseConfiguration> getConfiguration() async {
    final result = await _requesting.sendGETv3(_url.configuration);
    return ResponseConfiguration.fromJson(result.data);
  }

  @override
  Future<List<ResponseCast>> getCasts(int idMovie) async {
    final result = await _requesting.sendGETv3(_url.movieCast(idMovie));
    return result.data['cast']
        .map<ResponseCast>((cast) => ResponseCast.fromJson(cast))
        .toList();
  }

  @override
  Future<List<ResponseHomePageMovie>> getHomePageList(int categorySize) async {
    final result3 = <ResponseHomePageMovie>[];

    final setToCall2 = Iterable.generate(categorySize, (i) {
      return _requesting.sendGETv3(_url.trending, args: {'page': i * 10 + 1});
    });

    await Future.wait(setToCall2)
      ..forEach((categoryResponse) {
        ((categoryResponse.data as Map)['results'] as List).forEach((movie) {
          result3.add(ResponseHomePageMovie.fromJson(movie));
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

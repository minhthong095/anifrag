import 'package:Anifrag/model/responses/response_configuration.dart';
import 'package:Anifrag/model/responses/response_home_page_movie.dart';
import 'package:Anifrag/network/api_key.dart';
import 'package:Anifrag/network/requesting.dart';
import 'package:Anifrag/network/url.dart';
import 'package:inject/inject.dart';

abstract class AbsAPI {
  Future<ResponseConfiguration> getConfiguration();

  Future<List<String>> getCategories();

  Future<List<ResponseHomePageMovie>> getHomePageList(int categorySize);
}

class APIs extends AbsAPI {
  final Requesting _requesting;
  final RequestingAbiary _requestingAbiary;
  final AbsUrl _url;

  APIs(this._requesting, this._url, this._requestingAbiary);

  @override
  Future<ResponseConfiguration> getConfiguration() async {
    // final watch2 = Stopwatch()..start();
    // final result = await _requesting.sendGETv3(_url.configuration);
    // final result2 = await _requesting
    //     .sendGET(_url.configuration, args: {"api_key": ApiKey.v3});
    // final result10 = await _requesting
    //     .sendGET(_url.configuration, args: {"api_key": ApiKey.v3});
    // final result3 = await _requesting
    //     .sendGET(_url.configuration, args: {"api_key": ApiKey.v3});
    // final result4 = await _requesting
    //     .sendGET(_url.configuration, args: {"api_key": ApiKey.v3});
    // final result5 = await _requesting
    //     .sendGET(_url.configuration, args: {"api_key": ApiKey.v3});
    // final result6 = await _requesting
    //     .sendGET(_url.configuration, args: {"api_key": ApiKey.v3});
    // final result7 = await _requesting
    //     .sendGET(_url.configuration, args: {"api_key": ApiKey.v3});
    // final result8 = await _requesting
    //     .sendGET(_url.configuration, args: {"api_key": ApiKey.v3});
    // final result9 = await _requesting
    //     .sendGET(_url.configuration, args: {"api_key": ApiKey.v3});
    // print("stop1 " + watch2.elapsed.toString());
    // watch2.stop();

    // final watch = Stopwatch()..start();
    // final all = await Future.wait([
    //   _requesting.sendGETv3(_url.configuration),
    //   _requesting.sendGETv3(_url.configuration),
    //   _requesting.sendGETv3(_url.configuration),
    //   _requesting.sendGETv3(_url.configuration),
    //   _requesting.sendGETv3(_url.configuration),
    //   _requesting.sendGETv3(_url.configuration),
    //   _requesting.sendGETv3(_url.configuration),
    //   _requesting.sendGETv3(_url.configuration),
    //   _requesting.sendGETv3(_url.configuration),
    //   _requesting.sendGETv3(_url.configuration),
    // ]);
    // print("stop2 " + watch.elapsed.toString());
    // watch.stop();

    final result = await _requesting.sendGETv3(_url.configuration);
    return ResponseConfiguration.fromJson(result.data);
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

  @override
  Future<List<String>> getCategories() async {
    final result = await _requestingAbiary.sendGET(_url.categories);
    final data = result.data as Map<String, dynamic>;
    return data['categories'].cast<String>();
  }
}

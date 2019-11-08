import 'package:Anifrag/network/api_key.dart';
import 'package:Anifrag/network/url.dart';
import 'package:dio/dio.dart';
import 'package:inject/inject.dart';

abstract class AbsRequesting {
  Future<Response<T>> sendGET<T>(String url, {Map<String, dynamic> args});
}

class Requesting extends AbsRequesting {
  final Dio _dio;

  Requesting(this._dio);

  @override
  Future<Response<T>> sendGET<T>(String url,
      {Map<String, dynamic> args}) async {
    print("SEND GEND");
    return await _dio.get(url, queryParameters: args);
  }
}

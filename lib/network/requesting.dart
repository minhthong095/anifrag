import 'package:Anifrag/network/api_key.dart';
import 'package:Anifrag/di/module/module_network.dart';
import 'package:dio/dio.dart';
import 'package:inject/inject.dart';

abstract class AbsRequesting {
  Future<Response<T>> sendGET<T>(String url, {Map<String, dynamic> args});
}

class IGetV3 {
  void sendGETv3<T>(String url, {Map<String, dynamic> args}) {}
}

class Requesting extends AbsRequesting implements IGetV3 {
  final Dio _dio;

  Requesting(this._dio);

  @override
  Future<Response<T>> sendGET<T>(String url,
      {Map<String, dynamic> args}) async {
    return await _dio.get(url, queryParameters: args);
  }

  @override
  Future<Response<T>> sendGETv3<T>(String url,
      {Map<String, dynamic> args}) async {
    args ??= Map<String, dynamic>();
    args.putIfAbsent('api_key', () => ApiKey.v3);
    return await _dio.get(url, queryParameters: args);
  }
}

class RequestingAbiary extends AbsRequesting {
  final Dio _dio;

  @provide
  RequestingAbiary(this._dio);

  @override
  Future<Response<T>> sendGET<T>(String url,
      {Map<String, dynamic> args}) async {
    final a = _dio.options;
    return await _dio.get(url, queryParameters: args);
  }
}

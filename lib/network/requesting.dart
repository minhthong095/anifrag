import 'package:Anifrag/network/api_key.dart';
import 'package:Anifrag/network/url.dart';
import 'package:dio/dio.dart';
import 'package:inject/inject.dart';

abstract class AbsRequesting {
  void sendGET(String url, {Map<String, dynamic> args});
}

class Requesting extends AbsRequesting {
  final Dio _dio;

  @provide
  Requesting(this._dio);

  @override
  void sendGET(String url, {Map<String, dynamic> args}) async {
    final b = await _dio.get(url, queryParameters: args);
    final c = 1;
    print("SEND GEND");
  }
}

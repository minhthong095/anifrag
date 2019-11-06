import 'package:Anifrag/service/api_key.dart';
import 'package:Anifrag/service/url.dart';
import 'package:dio/dio.dart';

abstract class Requesting {
  final BaseOptions baseOptions = BaseOptions(
      connectTimeout: 5000,
      sendTimeout: 5000,
      baseUrl: Url.baseUrl,
      headers: {'Authentication': 'Bearer ' + ApiKey.v3});

  void superGet(String url, Map<String, dynamic> args);
}

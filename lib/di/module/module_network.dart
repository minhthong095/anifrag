import 'package:Anifrag/network/api_key.dart';
import 'package:Anifrag/network/apis.dart';
import 'package:Anifrag/network/requesting.dart';
import 'package:Anifrag/network/url.dart';
import 'package:dio/dio.dart';
import 'package:inject/inject.dart';

@module
class ModuleNetwork {
  @provide
  @singleton
  Dio dio() => Dio()
    ..options.baseUrl = Url.baseUrl
    ..options.connectTimeout = 5000
    ..options.sendTimeout = 5000
    ..options.headers = {'Authentication': 'Bearer ' + ApiKey.v3};

  @provide
  @singleton
  AbsRequesting requesting(Dio dio) => Requesting(dio);

  @provide
  AbsAPI api(Requesting requesting) => APIs(requesting);
}

import 'package:Anifrag/network/api_key.dart';
import 'package:Anifrag/network/apis.dart';
import 'package:Anifrag/network/requesting.dart';
import 'package:Anifrag/network/url.dart';
import 'package:dio/dio.dart';
import 'package:inject/inject.dart';
import 'package:sqflite/sqflite.dart';

const baseUrlApiary = const Qualifier(#baseUrlApiary);

@module
class ModuleNetwork {
  @provide
  @singleton
  Url url() => Url();

  @provide
  @singleton
  Dio dio() {
    return Dio()
      ..options.baseUrl = AbsUrl.baseUrl
      ..options.headers = {'Authentication': 'Bearer ' + ApiKey.v3};
  }

  @provide
  @baseUrlApiary
  Dio dioApiary() => Dio()..options.baseUrl = AbsUrl.baseUrlAbiary;

  @provide
  Requesting requesting(Dio dio) => Requesting(dio);

  @provide
  RequestingAbiary requestingAbiary(@baseUrlApiary Dio dioApiary) =>
      RequestingAbiary(dioApiary);

  @provide
  API api(Requesting requesting, Url url, RequestingAbiary requestingAbiary) =>
      ImplApi(requesting, url, requestingAbiary);
}

class A {}

import 'package:Anifrag/db/database_path.dart';
import 'package:Anifrag/network/api_key.dart';
import 'package:Anifrag/network/apis.dart';
import 'package:Anifrag/network/requesting.dart';
import 'package:Anifrag/network/url.dart';
import 'package:dio/dio.dart';
import 'package:inject/inject.dart';
import 'package:sqflite/sqflite.dart';

@module
class ModuleNetwork {
  @provide
  @singleton
  Url url() => Url();

  @provide
  @singleton
  Dio dio(Url url) {
    return Dio()
      ..options.baseUrl = url.baseUrl
      ..options.connectTimeout = 5000
      ..options.sendTimeout = 5000
      ..options.headers = {'Authentication': 'Bearer ' + ApiKey.v3};
  }

  @provide
  Requesting requesting(Dio dio) => Requesting(dio);

  @provide
  APIs api(Requesting requesting, Url url) => APIs(requesting, url);
}

class A {}

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
  Url url() => ImplUrl();

  @provide
  @singleton
  Dio dio() {
    return Dio()
      ..options.baseUrl = Url.baseUrl
      ..options.headers = {'Authentication': 'Bearer ' + ApiKey.v3};
  }

  @provide
  @baseUrlApiary
  Dio dioApiary() => Dio()..options.baseUrl = Url.baseUrlAbiary;

  @provide
  RequestingMovie normal(Dio dio) => RequestingMovieImplement(dio);

  @provide
  RequestingAbiary abiary(@baseUrlApiary Dio dioApiary) =>
      RequestingAbiaryImplement(dioApiary);

  @provide
  API api(RequestingMovie requesting, Url url,
          RequestingAbiary requestingAbiary) =>
      Api(requesting, url, requestingAbiary);
}

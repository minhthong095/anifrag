import 'package:Anifrag/model/model_configuration.dart';
import 'package:Anifrag/network/api_key.dart';
import 'package:Anifrag/network/requesting.dart';
import 'package:Anifrag/network/url.dart';
import 'package:inject/inject.dart';

abstract class AbsAPI {
  Future<ModelConfiguration> getConfiguration();
  void getList();
}

class APIs extends AbsAPI {
  final AbsRequesting _requesting;
  final AbsUrl _url;

  APIs(this._requesting, this._url);

  @override
  Future<ModelConfiguration> getConfiguration() async {
    final result = await _requesting
        .sendGET(_url.configuration, args: {"api_key": ApiKey.v3});
    return ModelConfiguration.fromJson(result.data);
  }

  @override
  void getList() {}
}
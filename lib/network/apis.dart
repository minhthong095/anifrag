import 'package:Anifrag/network/api_key.dart';
import 'package:Anifrag/network/requesting.dart';
import 'package:Anifrag/network/url.dart';
import 'package:inject/inject.dart';

abstract class AbsAPI {
  void getConfiguration();
  void getList();
}

class APIs extends AbsAPI {
  final AbsRequesting _requesting;
  final AbsUrl _url;

  APIs(this._requesting, this._url);

  @override
  void getConfiguration() {
    print("GET CONFIGURATION APIs " + _url.configuration);
    _requesting.sendGET(_url.configuration, args: {"api_key": ApiKey.v3});
  }

  @override
  void getList() {}
}

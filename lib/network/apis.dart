import 'package:Anifrag/network/requesting.dart';
import 'package:Anifrag/network/url.dart';
import 'package:inject/inject.dart';

abstract class AbsAPI {
  void getConfiguration();

  void getList();
}

class APIs extends AbsAPI {
  final Requesting _requesting;

  @provide
  APIs(this._requesting);

  @override
  void getConfiguration() {
    print("GET CONFIGURATION");
    _requesting.sendGET(Url.configuration);
  }

  @override
  void getList() {}
}

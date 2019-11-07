import 'package:Anifrag/network/apis.dart';
import 'package:inject/inject.dart';

class BlocInitialSplash {
  // inject IAPIs ( with include Requesting in there )
  final APIs _api;

  BlocInitialSplash(this._api);

  void init() {
    print("INIT BLOC INITIAL");
    _api.getConfiguration();
  }
}

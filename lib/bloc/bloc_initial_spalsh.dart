import 'package:Anifrag/config/shared_prefs.dart';
import 'package:Anifrag/network/apis.dart';
import 'package:Anifrag/store/app_db.dart';
import 'package:Anifrag/store/live_store.dart';
import 'package:Anifrag/store/offline/offline_configuration_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class BlocInitialSplash {
  // inject IAPIs ( with include Requesting in there )
  final APIs _api;
  final AppDb _appDb;
  final OfflineConfigurationImage _offConfigurationImage;
  final LiveStore _liveStore;

  SharedPreferences _prefs;

  BlocInitialSplash(
      this._api, this._appDb, this._offConfigurationImage, this._liveStore);

  void init() async {
    // String databasePath = await getDatabasesPath();
    // String path = databasePath + '/anifrag.db';
    // await deleteDatabase(path);
    // print("PATH DATABASE " + path);

    // _prefs = await SharedPreferences.getInstance();

    // _initDb();

    // _initConfiguration();
    _initHomePageData();
  }

  void _initConfiguration() async {
    final configuration = await _api.getConfiguration();

    _offConfigurationImage.insertPosterSizesAndChangeKeys(
        configuration.images.posterSizes, configuration.changeKeys);

    _liveStore.responseConfiguration = configuration;

    _prefs.setString(SharedPrefKey.baseUrlImage, configuration.secureBaseUrl);
  }

  void _initHomePageData() async {
    final categories = await _api.getCategories();
    final homePageData = await _api.getHomePageList(16);
    print("HIHI");
  }

  void _initDb() {
    _appDb.createDb();
  }
}

import 'package:Anifrag/config/shared_prefs.dart';
import 'package:Anifrag/di/module/module_store.dart';
import 'package:Anifrag/network/apis.dart';
import 'package:Anifrag/store/app_db.dart';
import 'package:Anifrag/store/data/configuration_image/live_configuration_image.dart';
import 'package:Anifrag/store/data/configuration_image/offline_configuration_image.dart';
import 'package:Anifrag/store/database_config.dart';
import 'package:dio/dio.dart';
import 'package:inject/inject.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class BlocInitialSplash {
  // inject IAPIs ( with include Requesting in there )
  final APIs _api;
  final AppDb _appDb;
  final OfflineConfigurationImage _offConfigurationImage;
  final LiveConfigurationImage _liveConfigurationImage;

  SharedPreferences _prefs;

  BlocInitialSplash(this._api, this._appDb, this._offConfigurationImage,
      this._liveConfigurationImage);

  void init() async {
    String databasePath = await getDatabasesPath();
    String path = databasePath + '/anifrag.db';
    await deleteDatabase(path);
    print("PATH DATABASE " + path);

    _prefs = await SharedPreferences.getInstance();

    _initDb();

    _initConfiguration();
  }

  void _initConfiguration() async {
    final configuration = await _api.getConfiguration();
    _offConfigurationImage.insertPosterSizesAndChangeKeys(
        configuration.images.posterSizes, configuration.changeKeys);

    _liveConfigurationImage.secureBaseImgUrl = configuration.secureBaseUrl;
    _liveConfigurationImage.posterSizes = configuration.images.posterSizes;
    _liveConfigurationImage.changeKey = configuration.changeKeys;

    _prefs.setString(
        SharedPrefKey.baseUrlImage, _liveConfigurationImage.secureBaseImgUrl);
  }

  void _initDb() {
    _appDb.createDb();
  }
}

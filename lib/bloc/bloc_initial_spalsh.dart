import 'package:Anifrag/config/shared_prefs.dart';
import 'package:Anifrag/di/module/module_store.dart';
import 'package:Anifrag/network/apis.dart';
import 'package:Anifrag/store/data/configuration_image/offline_configuration_image.dart';
import 'package:Anifrag/store/database_config.dart';
import 'package:Anifrag/store/live_store.dart';
import 'package:dio/dio.dart';
import 'package:inject/inject.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class BlocInitialSplash {
  // inject IAPIs ( with include Requesting in there )
  final APIs _api;
  final ILiveStore _liveStore;
  final AppDb _appDb;
  final OfflineConfigurationImage _offConfigurationImage;

  SharedPreferences _prefs;

  static const List<String> _scriptTableV1 = <String>[
    'CREATE TABLE ' +
        TablePosterSize.tableName +
        ' (id INTEGER PRIMARY KEY AUTOINCREMENT, ' +
        TablePosterSize.columnValue +
        ' TEXT)',
    'CREATE TABLE ' +
        TableChangeKey.tableName +
        ' (id INTEGER PRIMARY KEY AUTOINCREMENT, ' +
        TableChangeKey.columnValue +
        ' TEXT)'
  ];

  BlocInitialSplash(
      this._api, this._liveStore, this._appDb, this._offConfigurationImage);

  void init() async {
    String databasePath = await getDatabasesPath();
    String path = databasePath + '/anifrag.db';
    print("PATH DATABASE " + path);

    _prefs = await SharedPreferences.getInstance();

    _initDb();

    _initConfiguration();

    _closeDb();
  }

  void _initConfiguration() {
    _api.getConfiguration().then((configuration) {
      _offConfigurationImage
          .insertPosterSizes(configuration.images.posterSizes);
    });
  }

  void _initDb() {
    _appDb.createDb(_scriptTableV1);
  }

  void _closeDb() {
    _appDb.closeDb();
  }
}

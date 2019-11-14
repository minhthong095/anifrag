import 'package:Anifrag/config/shared_prefs.dart';
import 'package:Anifrag/network/apis.dart';
import 'package:Anifrag/store/app_db.dart';
import 'package:Anifrag/store/live_store.dart';
import 'package:Anifrag/store/offline/offline_category.dart';
import 'package:Anifrag/store/offline/offline_configuration_image.dart';
import 'package:Anifrag/store/offline/offline_home_page_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class BlocInitialSplash {
  // inject IAPIs ( with include Requesting in there )
  final APIs _api;
  final AppDb _appDb;
  final OfflineConfigurationImage _offConfigurationImage;
  final OfflineCategory _offCategory;
  final OfflineHomePageData _offHomePageData;
  final LiveStore _liveStore;

  SharedPreferences _prefs;

  BlocInitialSplash(this._api, this._appDb, this._offConfigurationImage,
      this._liveStore, this._offCategory, this._offHomePageData);

  void init() async {
    String databasePath = await getDatabasesPath();
    String path = databasePath + '/anifrag.db';
    await deleteDatabase(path);
    print("PATH DATABASE " + path);

    final watch = Stopwatch()..start();
    _prefs = await SharedPreferences.getInstance();

    await _initDb();

    await _initConfiguration();
    await _initHomePageData();
    print("Bench " + watch.elapsed.toString());
  }

  Future _initConfiguration() async {
    final configuration = await _api.getConfiguration();

    await _offConfigurationImage.insertPosterSizesAndChangeKeys(
        configuration.images.posterSizes, configuration.changeKeys);

    _liveStore.responseConfiguration = configuration;

    _prefs.setString(SharedPrefKey.baseUrlImage, configuration.secureBaseUrl);
    print("FINISH HOME CONFIGURATION DATA");
  }

  Future _initHomePageData() async {
    final categories = await _api.getCategories();
    final homePageData = await _api.getHomePageList(categories.length);

    _liveStore.categories = categories;
    _liveStore.homePageData = homePageData;

    await _offCategory.insertCategories(categories);
    await _offHomePageData.insertData(homePageData);
    print("FINISH HOME PAGE DATA");
  }

  Future _initDb() async {
    await _appDb.createDb();
  }
}

import 'package:Anifrag/model/responses/response_configuration.dart';
import 'package:Anifrag/model/responses/response_home_page_movie.dart';
import 'package:Anifrag/network/apis.dart';
import 'package:Anifrag/store/app_db.dart';
import 'package:Anifrag/store/live_store.dart';
import 'package:inject/inject.dart';
import 'package:sqflite/sqflite.dart';

@provide
class BlocInitialSplash {
  final API _api;
  final AppDb _appDb;
  // final OfflineCategory _offCategory;
  // final OfflineHomePageData _offHomePageData;
  final LiveStore _liveStore;

  // SharedPreferences _prefs;

  BlocInitialSplash(this._api, this._appDb, this._liveStore
      // , this._offCategory,
      //     this._offHomePageData
      );

  Future init(
      Function(
    bool,
    Map<String, List<ResponseThumbnailMovie>> homePageData,
  )
          finish) async {
    String databasePath = await getDatabasesPath();
    String path = databasePath + '/anifrag.db';
    // await deleteDatabase(path);
    print("PATH DATABASE " + path);

    final homePageData = Map<String, List<ResponseThumbnailMovie>>();
    final watch = Stopwatch()..start();

    await _appDb.createDb();

    final resultResponse = await _callPrerequisitesApi4();

    if (resultResponse.length > 0) {
      try {
        await _saveLocalPrerequisiteData(resultResponse[0]
            // , resultResponse[1], resultResponse[2]
            );
      } catch (e) {} finally {
        await _appDb.closeDb();
      }

      final categories = resultResponse[1] as List<String>;
      final movieCinemas = resultResponse[2] as List<ResponseThumbnailMovie>;
      final tvShows = resultResponse[3] as List<List<ResponseThumbnailMovie>>;

      final range = 20;
      int startIndex = 0;
      int endIndex = 0 + range;
      int tvShowIndex = 0;
      categories.forEach((category) {
        if (category[0] == 'T' && category[1] == 'V') {
          homePageData[category] = tvShows[tvShowIndex++];
        } else {
          homePageData[category] = movieCinemas.sublist(startIndex, endIndex);
          startIndex += range;
          endIndex += range;
        }
      });
    }

    finish(resultResponse.length > 0, homePageData);

    print("Bench " + watch.elapsed.toString());
  }

  Future<List<dynamic>> _callPrerequisitesApi4() async {
    var configureAndCategory;
    var movieCinemas;
    List<List<ResponseThumbnailMovie>> tvShows;
    try {
      configureAndCategory = await _api.getBothConfigureAndCategory();

      tvShows = await _getTvShowsWithCondition(
          configureAndCategory[1] as List<String>);

      movieCinemas = await _api // Categories length equal page count.
          .getMovieCinemaList((configureAndCategory[1] as List<String>).length -
              tvShows.length); // Remove tvshows item
    } catch (e) {
      print("Exception API " + e.toString());
      return [];
    }
    return [
      configureAndCategory[0] as ResponseConfiguration,
      configureAndCategory[1] as List<String>,
      movieCinemas,
      tvShows
    ];
  }

  Future<List<List<ResponseThumbnailMovie>>> _getTvShowsWithCondition(
      List<String> categories) async {
    final tvCategories = categories
        .where((value) => value[0] == 'T' && value[1] == 'V')
        .toList();
    final responseTvCategories =
        await _api.getPopularTvShows(tvCategories.length);
    return responseTvCategories;
  }

  Future _saveLocalPrerequisiteData(
    ResponseConfiguration configure,
    // List<String> categories,
    // List<ResponseThumbnailMovie> homePageData
  ) async {
    // _liveStore.setCategories = categories;
    _liveStore.setResponseConfiguration = configure;
    // _liveStore.setHomePageData = homePageData;

    // TODO: Full offline flow for HomePage
    // NOT USE RIGHT NOW
    // final db = await _appDb.db;
    // await db.transaction((txn) async {
    //   final batch = txn.batch();
    //   batch.execute(_offCategory.queryDeleteAll());
    //   batch.execute(_offHomePageData.queryDeleteAll());

    //   _offCategory.queryCategories(categories).forEach((queryC) {
    //     batch.execute(queryC);
    //     // Step 1
    //   });
    //   _offHomePageData.queryInsertThumbnail(homePageData).forEach((queryH) {
    //     batch.execute(queryH);
    //     // Step 2
    //   });
    //   batch.commit();
    //   // Step 3
    // });
    // Step 4
    // These steps are present how the flow run
  }

  // Future _initHomePageData() async {
  //   final categories = await _api.getCategories();
  //   final homePageData = await _api.getHomePageList(categories.length);

  //   _liveStore.categories = categories;
  //   _liveStore.homePageData = homePageData;

  //   final db = await _appDb.db;
  //   await db.transaction((txn) async {
  //     _offCategory.queryCategories(categories).forEach((queryC) {
  //       txn.rawInsert(queryC);
  //       // Step 1
  //     });
  //     _offHomePageData.queryInsertThumbnail(homePageData).forEach((queryH) {
  //       txn.rawInsert(queryH);
  //       // Step 2
  //     });
  //     // Step 3
  //   });
  //   // Step 4
  //   // These steps are present how the flow run
  // }
  // flutter: Test BENCH 0:00:03.544040
  // flutter: Test BENCH 0:00:02.540085
  // flutter: Test BENCH 0:00:02.555448
  // flutter: Test BENCH 0:00:04.052795
  // flutter: Test BENCH 0:00:02.469000
  // flutter: Test BENCH 0:00:02.707590
  // Future _callPrerequisitesApi() async {
  //   final watch = Stopwatch()..start();
  //   final configuration = await _api.getConfiguration();
  //   final categories = await _api.getCategories();
  //   final homePageData = await _api.getHomePageList(categories.length);
  //   print("Test BENCH " + watch.elapsed.toString());
  // }
  // flutter: Test BENCH 0:00:03.434162
  // flutter: Test BENCH 0:00:01.558500
  // flutter: DioError [DioErrorType.RESPONSE]: Http status error [429]
  // flutter: Test BENCH 0:00:01.385848
  // flutter: Test BENCH 0:00:02.692394
  // flutter: Test BENCH 0:00:02.372495
  // flutter: Test BENCH 0:00:02.587255
  // Future _callPrerequisitesApi2() async {
  //   final watch = Stopwatch()..start();
  //   final configureAndCategory =
  //       await Future.wait([_api.getConfiguration(), _api.getCategories()]);
  //   try {
  //     final homePageData = await _api
  //         .getHomePageList((configureAndCategory[1] as List<String>).length);
  //   } catch (e) {
  //     print(e.toString());
  //   }
  //   print("Test BENCH " + watch.elapsed.toString());
  // }
  // flutter: Test BENCH 0:00:03.575172
  // flutter: Test BENCH 0:00:01.609021
  // flutter: Test BENCH 0:00:01.833673
  // flutter: Test BENCH 0:00:01.590281
  // flutter: Test BENCH 0:00:03.299463
  // flutter: Test BENCH 0:00:03.404303
  // Future<List<dynamic>> _callPrerequisitesApi3() async {
  //   var configureAndCategory;
  //   var homePageData;
  //   try {
  //     configureAndCategory = await _api.getBothConfigureAndCategory();
  //     homePageData = await _api
  //         .getHomePageList((configureAndCategory[1] as List<String>).length);
  //   } catch (e) {
  //     return [];
  //   }
  //   return [
  //     configureAndCategory[0] as ResponseConfiguration,
  //     configureAndCategory[1] as List<String>,
  //     homePageData
  //   ];
  // }
  //   Future _initConfiguration() async {
  //   final configuration = await _api.getConfiguration();

  //   _offConfigurationImage.insertPosterSizesAndChangeKeys(
  //       configuration.images.posterSizes, configuration.changeKeys);

  //   _liveStore.responseConfiguration = configuration;

  //   _prefs.setString(
  //       SharedPrefKey.baseUrlImage, configuration.images.secureBaseUrl);
  // }
}

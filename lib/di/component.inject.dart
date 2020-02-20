import 'component.dart' as _i1;
import '../store/live_store.dart' as _i2;
import 'module/module_network.dart' as _i3;
import 'package:dio/src/dio.dart' as _i4;
import '../network/url.dart' as _i5;
import 'module/module_store.dart' as _i6;
import '../store/app_db.dart' as _i7;
import 'dart:async' as _i8;
import '../ui/screen/main_tab_bar.dart' as _i9;
import '../bloc/bloc_home.dart' as _i10;
import '../network/apis.dart' as _i11;
import '../network/requesting.dart' as _i12;
import '../store/offline/offline_movie.dart' as _i13;
import '../store/offline/offline_cast.dart' as _i14;
import '../bloc/bloc_maintab_bar.dart' as _i15;
import '../ui/screen/search.dart' as _i16;
import '../bloc/bloc_search_detail.dart' as _i17;
import '../bloc/bloc_search_view.dart' as _i18;
import '../ui/screen/detail.dart' as _i19;
import '../bloc/bloc_detail.dart' as _i20;
import '../ui/screen/initial_splash.dart' as _i21;
import '../bloc/bloc_initial_spalsh.dart' as _i22;
import '../store/offline/offline_category.dart' as _i23;
import '../store/offline/offline_home_page_data.dart' as _i24;

class ComponentInjector$Injector implements _i1.ComponentInjector {
  ComponentInjector$Injector._(this._moduleNetwork, this._moduleStore);

  _i2.LiveStore _singletonLiveStore;

  final _i3.ModuleNetwork _moduleNetwork;

  _i4.Dio _singletonDio;

  _i5.Url _singletonUrl;

  final _i6.ModuleStore _moduleStore;

  _i7.AppDb _singletonAppDb;

  String _singletonBaseUrlImgString;

  static _i8.Future<_i1.ComponentInjector> create(
      _i3.ModuleNetwork moduleNetwork, _i6.ModuleStore moduleStore) async {
    final injector = ComponentInjector$Injector._(moduleNetwork, moduleStore);

    return injector;
  }

  _i9.MainTabBarScreen _createMainTabBarScreen() => _i9.MainTabBarScreen(
      _createBlocHome(), _createBlocMainTabbar(), _createSearchScreen());
  _i10.BlocHome _createBlocHome() => _i10.BlocHome(
      _createLiveStore(),
      _createAPI(),
      _createOfflineMovie(),
      _createOfflineCast(),
      _createAppDb(),
      _createBlocMainTabbar(),
      _createBaseUrlImgString());
  _i2.LiveStore _createLiveStore() => _singletonLiveStore ??= _i2.LiveStore();
  _i11.API _createAPI() => _moduleNetwork.api(
      _createRequestingMovie(), _createUrl(), _createRequestingAbiary());
  _i12.RequestingMovie _createRequestingMovie() =>
      _moduleNetwork.normal(_createDio());
  _i4.Dio _createDio() => _singletonDio ??= _moduleNetwork.dio();
  _i5.Url _createUrl() => _singletonUrl ??= _moduleNetwork.url();
  _i12.RequestingAbiary _createRequestingAbiary() =>
      _moduleNetwork.abiary(_createBaseUrlApiaryDio());
  _i4.Dio _createBaseUrlApiaryDio() => _moduleNetwork.dioApiary();
  _i13.OfflineMovie _createOfflineMovie() => _moduleStore.offMovie();
  _i14.OfflineCast _createOfflineCast() => _moduleStore.offCast();
  _i7.AppDb _createAppDb() => _singletonAppDb ??= _moduleStore.db();
  _i15.BlocMainTabbar _createBlocMainTabbar() => _i15.BlocMainTabbar();
  String _createBaseUrlImgString() =>
      _singletonBaseUrlImgString ??= _moduleStore.url(_createLiveStore());
  _i16.SearchScreen _createSearchScreen() =>
      _i16.SearchScreen(_createBlocSearchDetail(), _createBlocSearchView());
  _i17.BlocSearchDetail _createBlocSearchDetail() =>
      _i17.BlocSearchDetail(_createAPI(), _createLiveStore());
  _i18.BlocSearchView _createBlocSearchView() => _i18.BlocSearchView(
      _createAPI(), _createLiveStore(), _createBaseUrlImgString());
  _i19.DetailScreen _createDetailScreen() =>
      _i19.DetailScreen(_createBlocHome(), _createBlocDetail());
  _i20.BlocDetail _createBlocDetail() => _i20.BlocDetail(
      _createLiveStore(), _createAPI(), _createBaseUrlImgString());
  _i21.InitialSplashScreen _createInitialSplashScreen() =>
      _i21.InitialSplashScreen(_createBlocInitialSplash());
  _i22.BlocInitialSplash _createBlocInitialSplash() => _i22.BlocInitialSplash(
      _createAPI(),
      _createAppDb(),
      _createLiveStore(),
      _createOfflineCategory(),
      _createOfflineHomePageData());
  _i23.OfflineCategory _createOfflineCategory() =>
      _moduleStore.offCategory(_createAppDb());
  _i24.OfflineHomePageData _createOfflineHomePageData() =>
      _moduleStore.offHomeData(_createAppDb());
  @override
  _i9.MainTabBarScreen get mainTabBarScreen => _createMainTabBarScreen();
  @override
  _i19.DetailScreen get detailScreen => _createDetailScreen();
  @override
  _i21.InitialSplashScreen get initialSplashScreen =>
      _createInitialSplashScreen();
}

import 'component.dart' as _i1;
import 'module/module_bloc.dart' as _i2;
import 'module/module_network.dart' as _i3;
import 'package:dio/src/dio.dart' as _i4;
import '../network/url.dart' as _i5;
import 'module/module_store.dart' as _i6;
import '../store/app_db.dart' as _i7;
import '../store/live_store.dart' as _i8;
import 'dart:async' as _i9;
import '../my_app.dart' as _i10;
import '../bloc/bloc_initial_spalsh.dart' as _i11;
import '../network/apis.dart' as _i12;
import '../network/requesting.dart' as _i13;
import '../store/offline/offline_configuration_image.dart' as _i14;
import '../store/offline/offline_category.dart' as _i15;
import '../store/offline/offline_home_page_data.dart' as _i16;

class ComponentInjector$Injector implements _i1.ComponentInjector {
  ComponentInjector$Injector._(
      this._moduleBloc, this._moduleNetwork, this._moduleStore);

  final _i2.ModuleBloc _moduleBloc;

  final _i3.ModuleNetwork _moduleNetwork;

  _i4.Dio _singletonDio;

  _i5.Url _singletonUrl;

  final _i6.ModuleStore _moduleStore;

  _i7.AppDb _singletonAppDb;

  _i8.LiveStore _singletonLiveStore;

  static _i9.Future<_i1.ComponentInjector> create(
      _i3.ModuleNetwork moduleNetwork,
      _i2.ModuleBloc moduleBloc,
      _i6.ModuleStore moduleStore) async {
    final injector =
        ComponentInjector$Injector._(moduleBloc, moduleNetwork, moduleStore);

    return injector;
  }

  _i10.MyApp _createMyApp() => _i10.MyApp(_createBlocInitialSplash());
  _i11.BlocInitialSplash _createBlocInitialSplash() =>
      _moduleBloc.blocInitialSplash(
          _createAPIs(),
          _createAppDb(),
          _createOfflineConfigurationImage(),
          _createLiveStore(),
          _createOfflineCategory(),
          _createOfflineHomePageData());
  _i12.APIs _createAPIs() => _moduleNetwork.api(
      _createRequesting(), _createUrl(), _createRequestingAbiary());
  _i13.Requesting _createRequesting() =>
      _moduleNetwork.requesting(_createDio());
  _i4.Dio _createDio() => _singletonDio ??= _moduleNetwork.dio();
  _i5.Url _createUrl() => _singletonUrl ??= _moduleNetwork.url();
  _i13.RequestingAbiary _createRequestingAbiary() =>
      _moduleNetwork.requestingAbiary(_createBaseUrlApiaryDio());
  _i4.Dio _createBaseUrlApiaryDio() => _moduleNetwork.dioApiary();
  _i7.AppDb _createAppDb() => _singletonAppDb ??= _moduleStore.db();
  _i14.OfflineConfigurationImage _createOfflineConfigurationImage() =>
      _moduleStore.offConfIma(_createAppDb());
  _i8.LiveStore _createLiveStore() =>
      _singletonLiveStore ??= _moduleStore.liveConfIma();
  _i15.OfflineCategory _createOfflineCategory() =>
      _moduleStore.offCategory(_createAppDb());
  _i16.OfflineHomePageData _createOfflineHomePageData() =>
      _moduleStore.offHomeData(_createAppDb());
  @override
  _i10.MyApp get app => _createMyApp();
}

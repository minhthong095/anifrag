import 'component.dart' as _i1;
import 'module/module_bloc.dart' as _i2;
import 'module/module_store.dart' as _i3;
import '../store/live_store.dart' as _i4;
import 'module/module_network.dart' as _i5;
import 'package:dio/src/dio.dart' as _i6;
import '../network/url.dart' as _i7;
import '../store/app_db.dart' as _i8;
import 'dart:async' as _i9;
import '../bloc/bloc_home.dart' as _i10;
import '../network/apis.dart' as _i11;
import '../network/requesting.dart' as _i12;
import '../store/offline/offline_cast.dart' as _i13;
import '../store/offline/offline_movie.dart' as _i14;
import '../bloc/bloc_maintab_bar.dart' as _i15;
import '../bloc/bloc_detail.dart' as _i16;
import '../bloc/bloc_initial_spalsh.dart' as _i17;
import '../store/offline/offline_configuration_image.dart' as _i18;
import '../store/offline/offline_category.dart' as _i19;
import '../store/offline/offline_home_page_data.dart' as _i20;

class ComponentInjector$Injector implements _i1.ComponentInjector {
  ComponentInjector$Injector._(
      this._moduleBloc, this._moduleStore, this._moduleNetwork);

  final _i2.ModuleBloc _moduleBloc;

  final _i3.ModuleStore _moduleStore;

  _i4.LiveStore _singletonLiveStore;

  final _i5.ModuleNetwork _moduleNetwork;

  _i6.Dio _singletonDio;

  _i7.Url _singletonUrl;

  _i8.AppDb _singletonAppDb;

  static _i9.Future<_i1.ComponentInjector> create(
      _i5.ModuleNetwork moduleNetwork,
      _i2.ModuleBloc moduleBloc,
      _i3.ModuleStore moduleStore) async {
    final injector =
        ComponentInjector$Injector._(moduleBloc, moduleStore, moduleNetwork);

    return injector;
  }

  _i10.BlocHome _createBlocHome() => _moduleBloc.blocHome(
      _createLiveStore(),
      _createImplApi(),
      _createOfflineCast(),
      _createOfflineMovie(),
      _createAppDb(),
      _createBlocMainTabbar());
  _i4.LiveStore _createLiveStore() =>
      _singletonLiveStore ??= _moduleStore.liveConfIma();
  _i11.ImplApi _createImplApi() => _moduleNetwork.api(
      _createRequesting(), _createUrl(), _createRequestingAbiary());
  _i12.Requesting _createRequesting() =>
      _moduleNetwork.requesting(_createDio());
  _i6.Dio _createDio() => _singletonDio ??= _moduleNetwork.dio();
  _i7.Url _createUrl() => _singletonUrl ??= _moduleNetwork.url();
  _i12.RequestingAbiary _createRequestingAbiary() =>
      _moduleNetwork.requestingAbiary(_createBaseUrlApiaryDio());
  _i6.Dio _createBaseUrlApiaryDio() => _moduleNetwork.dioApiary();
  _i13.OfflineCast _createOfflineCast() => _moduleStore.offCast();
  _i14.OfflineMovie _createOfflineMovie() => _moduleStore.offMovie();
  _i8.AppDb _createAppDb() => _singletonAppDb ??= _moduleStore.db();
  _i15.BlocMainTabbar _createBlocMainTabbar() => _moduleBloc.blocMainTabbar();
  _i16.BlocDetail _createBlocDetail() => _moduleBloc.blocDetail(
      _createOfflineMovie(), _createLiveStore(), _createImplApi());
  _i17.BlocInitialSplash _createBlocInitialSplash() =>
      _moduleBloc.blocInitialSplash(
          _createImplApi(),
          _createAppDb(),
          _createOfflineConfigurationImage(),
          _createLiveStore(),
          _createOfflineCategory(),
          _createOfflineHomePageData());
  _i18.OfflineConfigurationImage _createOfflineConfigurationImage() =>
      _moduleStore.offConfIma(_createAppDb());
  _i19.OfflineCategory _createOfflineCategory() =>
      _moduleStore.offCategory(_createAppDb());
  _i20.OfflineHomePageData _createOfflineHomePageData() =>
      _moduleStore.offHomeData(_createAppDb());
  @override
  _i10.BlocHome get blocHome => _createBlocHome();
  @override
  _i16.BlocDetail get blocDetail => _createBlocDetail();
  @override
  _i17.BlocInitialSplash get blocSplash => _createBlocInitialSplash();
  @override
  _i15.BlocMainTabbar get blocMainTabbar => _createBlocMainTabbar();
}

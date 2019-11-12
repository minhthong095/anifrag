import 'component.dart' as _i1;
import 'module/module_bloc.dart' as _i2;
import 'module/module_network.dart' as _i3;
import '../network/url.dart' as _i4;
import 'package:dio/src/dio.dart' as _i5;
import 'module/module_store.dart' as _i6;
import '../store/live_store.dart' as _i7;
import 'dart:async' as _i8;
import '../my_app.dart' as _i9;
import '../bloc/bloc_initial_spalsh.dart' as _i10;
import '../network/apis.dart' as _i11;
import '../network/requesting.dart' as _i12;
import '../store/data/configuration_image/offline_configuration_image.dart'
    as _i13;

class ComponentInjector$Injector implements _i1.ComponentInjector {
  ComponentInjector$Injector._(
      this._moduleBloc, this._moduleNetwork, this._moduleStore);

  final _i2.ModuleBloc _moduleBloc;

  final _i3.ModuleNetwork _moduleNetwork;

  _i4.Url _singletonUrl;

  _i5.Dio _singletonDio;

  final _i6.ModuleStore _moduleStore;

  _i7.LiveStore _singletonLiveStore;

  _i6.AppDb _singletonAppDb;

  static _i8.Future<_i1.ComponentInjector> create(
      _i3.ModuleNetwork moduleNetwork,
      _i2.ModuleBloc moduleBloc,
      _i6.ModuleStore moduleStore) async {
    final injector =
        ComponentInjector$Injector._(moduleBloc, moduleNetwork, moduleStore);

    return injector;
  }

  _i9.MyApp _createMyApp() =>
      _i9.MyApp(_createBlocInitialSplash(), _createLiveStore());
  _i10.BlocInitialSplash _createBlocInitialSplash() =>
      _moduleBloc.blocInitialSplash(_createAPIs(), _createLiveStore(),
          _createAppDb(), _createOfflineConfigurationImage());
  _i11.APIs _createAPIs() =>
      _moduleNetwork.api(_createRequesting(), _createUrl());
  _i12.Requesting _createRequesting() =>
      _moduleNetwork.requesting(_createDio());
  _i5.Dio _createDio() => _singletonDio ??= _moduleNetwork.dio(_createUrl());
  _i4.Url _createUrl() => _singletonUrl ??= _moduleNetwork.url();
  _i7.LiveStore _createLiveStore() =>
      _singletonLiveStore ??= _moduleStore.liveStore();
  _i6.AppDb _createAppDb() => _singletonAppDb ??= _moduleStore.db();
  _i13.OfflineConfigurationImage _createOfflineConfigurationImage() =>
      _moduleStore.offConfIma(_createAppDb());
  @override
  _i9.MyApp get app => _createMyApp();
}

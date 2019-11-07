import 'component.dart' as _i1;
import 'module/module_bloc.dart' as _i2;
import 'module/module_network.dart' as _i3;
import '../network/url.dart' as _i4;
import 'package:dio/src/dio.dart' as _i5;
import 'dart:async' as _i6;
import '../my_app.dart' as _i7;
import '../bloc/bloc_initial_spalsh.dart' as _i8;
import '../network/apis.dart' as _i9;
import '../network/requesting.dart' as _i10;

class ComponentInjector$Injector implements _i1.ComponentInjector {
  ComponentInjector$Injector._(this._moduleBloc, this._moduleNetwork);

  final _i2.ModuleBloc _moduleBloc;

  final _i3.ModuleNetwork _moduleNetwork;

  _i4.Url _singletonUrl;

  _i5.Dio _singletonDio;

  static _i6.Future<_i1.ComponentInjector> create(
      _i3.ModuleNetwork moduleNetwork, _i2.ModuleBloc moduleBloc) async {
    final injector = ComponentInjector$Injector._(moduleBloc, moduleNetwork);

    return injector;
  }

  _i7.MyApp _createMyApp() => _i7.MyApp(_createBlocInitialSplash());
  _i8.BlocInitialSplash _createBlocInitialSplash() =>
      _moduleBloc.blocInitialSplash(_createAPIs());
  _i9.APIs _createAPIs() =>
      _moduleNetwork.api(_createRequesting(), _createUrl());
  _i10.Requesting _createRequesting() =>
      _moduleNetwork.requesting(_createDio());
  _i5.Dio _createDio() => _singletonDio ??= _moduleNetwork.dio(_createUrl());
  _i4.Url _createUrl() => _singletonUrl ??= _moduleNetwork.url();
  @override
  _i7.MyApp get app => _createMyApp();
}

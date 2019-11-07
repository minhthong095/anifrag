import 'component.dart' as _i1;
import 'module.dart' as _i2;
import 'dart:async' as _i3;
import '../my_app.dart' as _i4;

class ComponentInjector$Injector implements _i1.ComponentInjector {
  ComponentInjector$Injector._(this._module);

  final _i2.Module _module;

  static _i3.Future<_i1.ComponentInjector> create(_i2.Module module) async {
    final injector = ComponentInjector$Injector._(module);

    return injector;
  }

  _i4.MyApp _createMyApp() =>
      _i4.MyApp(_createRequesting2(), _createRequesting2());
  _i2.Requesting2 _createRequesting2() => _module.requesting();
  @override
  _i4.MyApp get app => _createMyApp();
}

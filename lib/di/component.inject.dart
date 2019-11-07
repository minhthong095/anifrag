import 'component.dart' as _i1;
import 'dart:async' as _i2;
import 'module.dart' as _i3;
import '../my_app.dart' as _i4;

class ComponentInjector$Injector implements _i1.ComponentInjector {
  ComponentInjector$Injector._();

  static _i2.Future<_i1.ComponentInjector> create(_i3.Module _) async {
    final injector = ComponentInjector$Injector._();

    return injector;
  }

  _i4.MyApp _createMyApp() => _i4.MyApp();
  @override
  _i4.MyApp get app => _createMyApp();
}

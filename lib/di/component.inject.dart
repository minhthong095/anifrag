import 'component.dart' as _i1;
import 'dart:async' as _i2;
import 'module/module_network.dart' as _i3;
import 'module/module_bloc.dart' as _i4;
import '../my_app.dart' as _i5;

class ComponentInjector$Injector implements _i1.ComponentInjector {
  ComponentInjector$Injector._();

  static _i2.Future<_i1.ComponentInjector> create(
      _i3.ModuleNetwork _, _i4.ModuleBloc __) async {
    final injector = ComponentInjector$Injector._();

    return injector;
  }

  @override
  _i5.MyApp get app => null;
}

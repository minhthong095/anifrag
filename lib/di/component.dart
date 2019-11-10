import 'package:Anifrag/di/module/module_bloc.dart';
import 'package:Anifrag/di/module/module_network.dart';
import 'package:Anifrag/di/module/module_store.dart';
import 'package:Anifrag/my_app.dart';
import 'package:inject/inject.dart';
import 'component.inject.dart' as g;
// @Injector(const [ModuleNetwork])

@Injector(const [ModuleNetwork, ModuleBloc, ModuleStore])
abstract class ComponentInjector {
  MyApp get app;

  static final create = g.ComponentInjector$Injector.create;
}

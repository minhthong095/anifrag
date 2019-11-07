import 'package:Anifrag/di/module.dart';
import 'package:Anifrag/root/my_app.dart';
import 'package:inject/inject.dart';
import 'component.inject.dart' as g;

@Injector(const [Module])
abstract class ComponentInjector {
  MyApp get app;

  static final create = g.ComponentInjector$Injector.create;
}

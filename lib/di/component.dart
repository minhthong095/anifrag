import 'package:Anifrag/di/module.dart';
import 'package:Anifrag/my_app.dart';
import 'package:inject/inject.dart';
import 'component.inject.dart' as g;

@Injector(const [Module])
abstract class ComponentInjector {
  @provide
  MyApp get app;

  static final create = g.ComponentInjector$Injector.create;
}

import 'package:Anifrag/bloc/bloc_detail.dart';
import 'package:Anifrag/bloc/bloc_home.dart';
import 'package:Anifrag/bloc/bloc_initial_spalsh.dart';
import 'package:Anifrag/bloc/bloc_maintab_bar.dart';
import 'package:Anifrag/bloc/bloc_search_detail.dart';
import 'package:Anifrag/bloc/bloc_search_view.dart';
import 'package:Anifrag/di/module/module_network.dart';
import 'package:Anifrag/di/module/module_store.dart';
import 'package:inject/inject.dart';

import 'component.inject.dart' as g;

const testQualifier = const Qualifier(#testQualifier);

/// This package still not supported like Dagger2 with inject annotation.

@Injector(const [ModuleNetwork, ModuleStore])
abstract class ComponentInjector {
  BlocDetail get blocDetailComponent;

  BlocHome get blocHomeComponent;

  BlocInitialSplash get blocInitialSplashComponent;

  BlocMainTabbar get blocMainTabbarComponent;

  BlocSearchDetail get blocSearchDetailComponent;

  BlocSearchView get blocSearchViewComponent;

  static Future<ComponentInjector> create() {
    return g.ComponentInjector$Injector.create(ModuleNetwork(), ModuleStore());
  }
}

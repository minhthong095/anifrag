import 'dart:io';

import 'package:Anifrag/bloc/bloc_detail.dart';
import 'package:Anifrag/bloc/bloc_home.dart';
import 'package:Anifrag/bloc/bloc_initial_spalsh.dart';
import 'package:Anifrag/bloc/bloc_maintab_bar.dart';
import 'package:Anifrag/bloc/bloc_search_detail.dart';
import 'package:Anifrag/bloc/bloc_search_view.dart';
import 'package:Anifrag/di/module/module_bloc.dart';
import 'package:Anifrag/di/module/module_network.dart';
import 'package:Anifrag/di/module/module_store.dart';
import 'package:Anifrag/my_app.dart';
import 'package:Anifrag/network/url.dart';
import 'package:Anifrag/store/live_store.dart';
import 'package:Anifrag/ui/screen/detail.dart';
import 'package:Anifrag/ui/screen/initial_splash.dart';
import 'package:Anifrag/ui/screen/main_tab_bar.dart';
import 'package:inject/inject.dart';
import 'component.inject.dart' as g;

/// This package still not supported like Dagger2 with inject annotation.

@Injector(const [ModuleNetwork, ModuleStore])
abstract class ComponentInjector {
  MainTabBarScreen get mainTabBarScreen;

  DetailScreen get detailScreen;

  InitialSplashScreen get initialSplashScreen;

  static Future<ComponentInjector> create() {
    return g.ComponentInjector$Injector.create(ModuleNetwork(), ModuleStore());
  }
}

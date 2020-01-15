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
import 'package:Anifrag/store/live_store.dart';
import 'package:inject/inject.dart';
import 'component.inject.dart' as g;
// @Injector(const [ModuleNetwork])

@Injector(const [ModuleNetwork, ModuleBloc, ModuleStore])
abstract class ComponentInjector {
  // This is dynamic injector thanks to https://github.com/asi-pwr/HackYeah2019
  BlocHome get blocHome;

  // This is dynamic injector thanks to https://github.com/asi-pwr/HackYeah2019
  BlocDetail get blocDetail;

  // This is dynamic injector thanks to https://github.com/asi-pwr/HackYeah2019
  BlocInitialSplash get blocSplash;

  BlocMainTabbar get blocMainTabbar;

  BlocSearchView get blocSearchView;

  BlocSearchDetail get blocSearchDetail;

  LiveStore get liveStore;

  static create() async {
    _instance = await g.ComponentInjector$Injector.create(
        ModuleNetwork(), ModuleBloc(), ModuleStore());
  }

  // static final create = g.ComponentInjector$Injector.create;

  static ComponentInjector _instance;
  static ComponentInjector get I {
    if (_instance == null)
      throw Exception(['ComponentInjector still not implment.']);

    return _instance;
  }
}

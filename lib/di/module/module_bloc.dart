import 'package:Anifrag/bloc/bloc_initial_spalsh.dart';
import 'package:Anifrag/di/module/module_network.dart';
import 'package:Anifrag/di/module/module_store.dart';
import 'package:Anifrag/network/apis.dart';
import 'package:Anifrag/store/live_store.dart';
import 'package:inject/inject.dart';

@module
class ModuleBloc {
  @provide
  BlocInitialSplash blocInitialSplash(
          APIs api, LiveStore liveStore, AppDb db) =>
      BlocInitialSplash(api, liveStore, db);
}

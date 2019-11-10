import 'package:Anifrag/store/live_store.dart';
import 'package:inject/inject.dart';

@module
class ModuleStore {
  @provide
  @singleton
  LiveStore liveStore() => LiveStore();
}

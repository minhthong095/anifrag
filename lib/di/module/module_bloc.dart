import 'package:Anifrag/bloc/bloc_initial_spalsh.dart';
import 'package:Anifrag/network/apis.dart';
import 'package:Anifrag/store/app_db.dart';
import 'package:Anifrag/store/live_store.dart';
import 'package:Anifrag/store/offline/offline_configuration_image.dart';
import 'package:inject/inject.dart';

@module
class ModuleBloc {
  @provide
  BlocInitialSplash blocInitialSplash(
          APIs api,
          AppDb appDb,
          OfflineConfigurationImage offConfigurationImage,
          LiveStore liveConfigurationImage) =>
      BlocInitialSplash(
          api, appDb, offConfigurationImage, liveConfigurationImage);
}

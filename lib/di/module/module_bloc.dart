import 'package:Anifrag/bloc/bloc_initial_spalsh.dart';
import 'package:Anifrag/network/apis.dart';
import 'package:Anifrag/store/app_db.dart';
import 'package:Anifrag/store/data/configuration_image/live_configuration_image.dart';
import 'package:Anifrag/store/data/configuration_image/offline_configuration_image.dart';
import 'package:inject/inject.dart';

@module
class ModuleBloc {
  @provide
  BlocInitialSplash blocInitialSplash(
          APIs api,
          AppDb appDb,
          OfflineConfigurationImage offConfigurationImage,
          LiveConfigurationImage liveConfigurationImage) =>
      BlocInitialSplash(
          api, appDb, offConfigurationImage, liveConfigurationImage);
}

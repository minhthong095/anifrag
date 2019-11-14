import 'package:Anifrag/bloc/bloc_initial_spalsh.dart';
import 'package:Anifrag/network/apis.dart';
import 'package:Anifrag/store/app_db.dart';
import 'package:Anifrag/store/live_store.dart';
import 'package:Anifrag/store/offline/offline_category.dart';
import 'package:Anifrag/store/offline/offline_configuration_image.dart';
import 'package:Anifrag/store/offline/offline_home_page_data.dart';
import 'package:inject/inject.dart';

@module
class ModuleBloc {
  @provide
  BlocInitialSplash blocInitialSplash(
          APIs api,
          AppDb appDb,
          OfflineConfigurationImage offConfigurationImage,
          LiveStore liveConfigurationImage,
          OfflineCategory offlineCategory,
          OfflineHomePageData offHomePageData) =>
      BlocInitialSplash(api, appDb, offConfigurationImage,
          liveConfigurationImage, offlineCategory, offHomePageData);
}

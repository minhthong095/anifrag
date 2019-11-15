import 'package:Anifrag/bloc/bloc_home.dart';
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
          LiveStore liveStore,
          OfflineCategory offlineCategory,
          OfflineHomePageData offHomePageData) =>
      BlocInitialSplash(api, appDb, offConfigurationImage, liveStore,
          offlineCategory, offHomePageData);

  @provide
  BlocHome blocHome(LiveStore liveStore) => BlocHome(liveStore);
}

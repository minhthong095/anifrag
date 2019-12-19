import 'package:Anifrag/bloc/bloc_detail.dart';
import 'package:Anifrag/bloc/bloc_home.dart';
import 'package:Anifrag/bloc/bloc_initial_spalsh.dart';
import 'package:Anifrag/bloc/bloc_maintab_bar.dart';
import 'package:Anifrag/bloc/bloc_search_detail.dart';
import 'package:Anifrag/bloc/bloc_search_view.dart';
import 'package:Anifrag/bloc/bloc_search_view.dart';
import 'package:Anifrag/network/apis.dart';
import 'package:Anifrag/store/app_db.dart';
import 'package:Anifrag/store/live_store.dart';
import 'package:Anifrag/store/offline/offline_cast.dart';
import 'package:Anifrag/store/offline/offline_category.dart';
import 'package:Anifrag/store/offline/offline_configuration_image.dart';
import 'package:Anifrag/store/offline/offline_home_page_data.dart';
import 'package:Anifrag/store/offline/offline_movie.dart';
import 'package:inject/inject.dart';

@module
class ModuleBloc {
  @provide
  BlocInitialSplash blocInitialSplash(
          API api,
          AppDb appDb,
          OfflineConfigurationImage offConfigurationImage,
          LiveStore liveStore,
          OfflineCategory offlineCategory,
          OfflineHomePageData offHomePageData) =>
      BlocInitialSplash(api, appDb, offConfigurationImage, liveStore,
          offlineCategory, offHomePageData);

  @provide
  BlocMainTabbar blocMainTabbar() => BlocMainTabbar();

  @provide
  BlocHome blocHome(LiveStore liveStore, API api, OfflineCast offCast,
          OfflineMovie offMovie, AppDb appDb, BlocMainTabbar blocMainTabbar) =>
      BlocHome(liveStore, api, offMovie, offCast, appDb, blocMainTabbar);

  @provide
  BlocDetail blocDetail(OfflineMovie offMovie, LiveStore liveStore, API api) =>
      BlocDetail(offMovie, liveStore, api);

  @provide
  BlocSearchView blocSearch(API api, LiveStore liveStore) =>
      BlocSearchView(api, liveStore);

  @provide
  BlocSearchDetail blocSearchDetail(API api, LiveStore liveStore) =>
      BlocSearchDetail(api, liveStore);
}

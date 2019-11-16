import 'dart:async';

import 'package:Anifrag/store/app_db.dart';
import 'package:Anifrag/store/live_store.dart';
import 'package:Anifrag/store/offline/offline_cast.dart';
import 'package:Anifrag/store/offline/offline_category.dart';
import 'package:Anifrag/store/offline/offline_configuration_image.dart';
import 'package:Anifrag/store/offline/offline_home_page_data.dart';
import 'package:Anifrag/store/offline/offline_movie.dart';
import 'package:inject/inject.dart';
import 'package:sqflite/sqflite.dart';

@module
class ModuleStore {
  @provide
  @singleton
  AppDb db() => AppDb();

  @provide
  @singleton
  LiveStore liveConfIma() => LiveStore();

  @provide
  OfflineConfigurationImage offConfIma(AppDb db) =>
      OfflineConfigurationImage(db);

  @provide
  OfflineCategory offCategory(AppDb db) => OfflineCategory(db);

  @provide
  OfflineHomePageData offHomeData(AppDb db) => OfflineHomePageData(db);

  @provide
  OfflineMovie offMovie() => OfflineMovie();

  @provide
  OfflineCast offCast() => OfflineCast();
}

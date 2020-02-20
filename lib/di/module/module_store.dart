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

const baseUrlImg = const Qualifier(#baseUrlImg);

@module
class ModuleStore {
  @provide
  @singleton
  AppDb db() => SqfDb();

  @provide
  @singleton
  @baseUrlImg
  String url(LiveStore liveStore) => liveStore.baseUrlImage;

  @provide
  OfflineCategory offCategory(AppDb db) => ImplOfflineCategory(db);

  @provide
  OfflineHomePageData offHomeData(AppDb db) => ImplOfflineHomePageData(db);

  @provide
  OfflineMovie offMovie() => ImplOfflineMovie();

  @provide
  OfflineCast offCast() => ImplOfflineCast();
}

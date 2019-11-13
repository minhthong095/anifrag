import 'dart:async';

import 'package:Anifrag/store/app_db.dart';
import 'package:Anifrag/store/data/configuration_image/live_configuration_image.dart';
import 'package:Anifrag/store/data/configuration_image/offline_configuration_image.dart';
import 'package:inject/inject.dart';
import 'package:sqflite/sqflite.dart';

@module
class ModuleStore {
  @provide
  @singleton
  AppDb db() => AppDb();

  @provide
  @singleton
  LiveConfigurationImage liveConfIma() => LiveConfigurationImage();

  @provide
  OfflineConfigurationImage offConfIma(AppDb db) =>
      OfflineConfigurationImage(db);
}

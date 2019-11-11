import 'dart:async';

import 'package:Anifrag/store/live_store.dart';
import 'package:inject/inject.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';

@module
class ModuleStore {
  @provide
  @singleton
  LiveStore liveStore() => LiveStore();

  @provide
  @singleton
  AppDb db() => AppDb();
}

class AppDb {
  String _dbPath;

  Database _db;

  final _lock = Lock();

  AppDb() {
    _initDbPath();
  }

  void _initDbPath() async {
    _dbPath = await getDatabasesPath();
    _dbPath += "/anifrag.db";
  }

  Future createDb(List<String> scripts) async {
    await _lock.synchronized(() async {
      _db = await openDatabase(_dbPath, version: 1,
          onCreate: (db, version) async {
        final batch = db.batch();
        scripts.forEach((script) {
          batch.execute(script);
        });
        batch.commit();
      });
    });
  }

  Future<Database> getDb() async {
    if (_db == null) {
      await _lock.synchronized(() async {
        // Check again once entering the synchronized block
        if (_db == null) {
          _db = await openDatabase(_dbPath);
        }
      });
    }
    return _db;
  }

  Future closeDb() async {
    await _db.close();
  }
}

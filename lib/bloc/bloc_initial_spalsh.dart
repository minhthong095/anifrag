import 'package:Anifrag/di/module/module_store.dart';
import 'package:Anifrag/network/apis.dart';
import 'package:Anifrag/store/live_store.dart';
import 'package:dio/dio.dart';
import 'package:inject/inject.dart';
import 'package:sqflite/sqflite.dart';

class BlocInitialSplash {
  // inject IAPIs ( with include Requesting in there )
  final APIs _api;
  final ILiveStore _liveStore;
  final AppDb _db;

  Database _database;

  static const List<String> _scriptTable = <String>[
    'CREATE TABLE POSTER_SIZE (id INTEGER PRIMARY KEY AUTOINCREMENT, value TEXT)',
    'CREATE TABLE CHANGE_KEY (id INTEGER PRIMARY KEY AUTOINCREMENT, valueX TEXT)'
  ];

  BlocInitialSplash(this._api, this._liveStore, this._db);

  void init(VoidCallback a) async {
    // _api.getConfiguration();
    // _liveStore.posterSizes = <String>["OI GIAC CHIEM BAO"];
    // a();
    String databasePath = await getDatabasesPath();
    String path = databasePath + '/anifrag.db';
    print("PATH DATABASE " + path);
    await deleteDatabase(path);
    // Database database = await openDatabase(path, version: 1,
    //     onCreate: (Database db, int version) async {
    //   print("DATABSE CREATE BLOCINITSPALH");
    //   await db.execute(
    //       "CREATE TABLE POSTER_SIZE (id INTEGER PRIMARY KEY AUTOINCREMENT, value TEXT)");
    //   await db.execute(
    //       'CREATE TABLE CHANGE_KEY (id INTEGER PRIMARY KEY AUTOINCREMENT, value TEXT)');
    // });

    // Database database2 = await openDatabase(path);

    // await database.transaction((transaction) async {
    //   for (int i = 0; i < 10000; i++) {
    //     // int i = 1;
    //     transaction.rawInsert(
    //         'INSERT INTO CHANGE_KEY (value) VALUES ("' + i.toString() + '")');
    //     transaction.rawInsert(
    //         'INSERT INTO POSTER_SIZE (value) VALUES ("' + i.toString() + '")');
    //   }
    // });

    // await database.close();
    // print("END INIT BLOCINITSPALH");

    await _db.createDb(_scriptTable);

    await _db.getDb();

    await _db.closeDb();
  }
}

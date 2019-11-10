import 'package:Anifrag/network/apis.dart';
import 'package:Anifrag/store/live_store.dart';
import 'package:dio/dio.dart';
import 'package:inject/inject.dart';
import 'package:sqflite/sqflite.dart';

class BlocInitialSplash {
  // inject IAPIs ( with include Requesting in there )
  final APIs _api;
  final ILiveStore _liveStore;

  BlocInitialSplash(this._api, this._liveStore);

  void init(VoidCallback a) {
    // _api.getConfiguration();
    _liveStore.posterSizes = <String>["OI GIAC CHIEM BAO"];
    a();
    // String databasePath = await getDatabasesPath();
    // String path = databasePath + 'anifrag.db';
    // print("PATH DATABASE " + path);
    // await deleteDatabase(path);
    // Database database = await openDatabase(path, version: 1,
    //     onCreate: (Database db, int version) async {
    //   print("DATABSE CREATE BLOCINITSPALH");
    //   await db.execute(
    //       "CREATE TABLE POSTER_SIZE (id INTEGER PRIMARY KEY AUTOINCREMENT, value TEXT)");
    //   await db.execute(
    //       'CREATE TABLE CHANGE_KEY (id INTEGER PRIMARY KEY AUTOINCREMENT, value TEXT)');
    // });

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
  }
}

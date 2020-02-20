import 'package:Anifrag/di/module/module_store.dart';
import 'package:Anifrag/store/database_config.dart';
import 'package:inject/inject.dart';
import 'package:sqflite/sqlite_api.dart';

import '../app_db.dart';

abstract class OfflineConfigurationImage {
  Future insertPosterSizesAndChangeKeys(
      List<String> posterSizes, List<String> changeKeys);
}

class ImplOfflineConfigurationImage extends OfflineConfigurationImage {
  final AppDb _appDb;

  ImplOfflineConfigurationImage(this._appDb);

  Future insertPosterSizesAndChangeKeys(
      List<String> posterSizes, List<String> changeKeys) async {
    final db = await _appDb.db;
    await db.transaction((txn) async {
      posterSizes.forEach((poster) async {
        await txn.rawInsert(
            'INSERT INTO ' +
                TablePosterSize.tableName +
                '(' +
                TablePosterSize.columnValue +
                ') VALUES(?)',
            [poster]);
      });
      changeKeys.forEach((key) async {
        await txn.rawInsert(
            'INSERT INTO ' +
                TableChangeKey.tableName +
                '(' +
                TableChangeKey.columnValue +
                ') VALUES(?)',
            [key]);
      });
    });
    // await _appDb.closeDb();
  }
}

abstract class A {
  String getA();
}

class OffliveA extends A {
  @override
  String getA() {
    // TODO: implement getA
    return null;
  }
}

class LiveA extends A {
  @override
  String getA() {
    // TODO: implement getA
    return null;
  }
}

class AX extends A {
  final OffliveA a1;
  final LiveA a2;
  AX(this.a1, this.a2);

  @override
  String getA() {
    try {
      return a1.getA();
    } catch (e) {
      return a2.getA();
    }
  }
}

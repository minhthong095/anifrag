import 'package:Anifrag/di/module/module_store.dart';
import 'package:Anifrag/store/database_config.dart';
import 'package:sqflite/sqlite_api.dart';

class OfflineConfigurationImage {
  final AppDb _appDb;

  OfflineConfigurationImage(this._appDb);

  void insertPosterSizes(List<String> posterSizes) {
    _appDb.getDb().then((db) {
      db.transaction((txn) async {
        posterSizes.forEach((poster) async {
          await txn.rawInsert('INSERT INTO ?(?) VALUES(?)',
              [TablePosterSize.tableName, TablePosterSize.columnValue, poster]);
        });
      });
      db.close();
    });
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

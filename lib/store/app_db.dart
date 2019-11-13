import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:synchronized/synchronized.dart';

import 'database_config.dart';

class AppDb {
  static const List<String> _scriptTableV1 = <String>[
    'CREATE TABLE ' +
        TablePosterSize.tableName +
        ' (id INTEGER PRIMARY KEY AUTOINCREMENT, ' +
        TablePosterSize.columnValue +
        ' TEXT)',
    'CREATE TABLE ' +
        TableChangeKey.tableName +
        ' (id INTEGER PRIMARY KEY AUTOINCREMENT, ' +
        TableChangeKey.columnValue +
        ' TEXT)'
  ];

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

  Future createDb() async {
    await _lock.synchronized(() async {
      final db = await openDatabase(_dbPath, version: 1,
          onCreate: (db, version) async {
        final batch = db.batch();
        _scriptTableV1.forEach((script) {
          batch.execute(script);
        });
        batch.commit();
        db.close();
        print("CLOSE DB WHEN CREATE");
      });
      print("IS OPEN WHEN CREATE: " + db.isOpen.toString());
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

  bool isOpen() {
    return _db.isOpen;
  }
}

import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:synchronized/synchronized.dart';

import 'database_config.dart';

abstract class AppDb {
  bool get isOpen;
  Future<Database> get db;
  Future<void> closeDb();
  Future createDb();
}

class SqfDb extends AppDb {
  Database _db;
  String _dbPath;
  final _lock = Lock();

  SqfDb() {
    _initDbPath();
  }

  void _initDbPath() async {
    _dbPath = await getDatabasesPath();
    _dbPath += "/anifrag.db";
  }

  @override
  Future<void> closeDb() async {
    if (_db != null) {
      await _db.close();
      _db = null;
    }
  }

  @override
  Future createDb() async {
    await _lock.synchronized(() async {
      final db = await openDatabase(_dbPath, version: 1,
          onCreate: (db, version) async {
        final batch = db.batch();
        _scriptTableV1.forEach((script) {
          batch.execute(script);
        });
        batch.commit();
        print("CLOSE DB WHEN CREATE");
      });
      // db.close();
      print("IS OPEN WHEN CREATE: " + db.isOpen.toString());
    });
  }

  @override
  Future<Database> get db async {
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

  @override
  bool get isOpen => _db.isOpen;

  static const List<String> _scriptTableV1 = <String>[
    'CREATE TABLE ' +
        TableThumnailMovie.tableName +
        '\(no INTEGER PRIMARY KEY AUTOINCREMENT, ' +
        TableThumnailMovie.columnIdMovie +
        ' INTEGER, ' +
        TableThumnailMovie.columnPosterPath +
        ' TEXT)',
    'CREATE TABLE ' +
        TableCategory.tableName +
        '\(no INTEGER PRIMARY KEY AUTOINCREMENT, ' +
        TableCategory.columnName +
        ' TEXT)',
    'CREATE TABLE ' +
        TableMovie.tableName +
        '\(no INTEGER PRIMARY KEY AUTOINCREMENT, ' +
        TableMovie.columnIdMovie +
        ' INTEGER, ' +
        TableMovie.columnOverview +
        ' TEXT, ' +
        TableMovie.columnRuntime +
        ' INTEGER, ' +
        TableMovie.columnPopularity +
        ' FLOAT, ' +
        TableMovie.columnTitle +
        ' TEXT, ' +
        TableMovie.columnReleaseDate +
        ' DATETIME, ' +
        TableMovie.columnVoteAverage +
        ' FLOAT, ' +
        TableMovie.columnPosterPath +
        ' TEXT, ' +
        TableMovie.columnVoteCount +
        ' INTEGER)',
    'CREATE TABLE ' +
        TableCast.tableName +
        '\(no INTEGER PRIMARY KEY AUTOINCREMENT, ' +
        TableCast.columnName +
        ' TEXT, ' +
        TableCast.columnIdMovie +
        ' INTEGER)'
  ];
}

// 'CREATE TABLE ' +
//     TablePosterSize.tableName +
//     ' \(no INTEGER PRIMARY KEY AUTOINCREMENT, ' +
//     TablePosterSize.columnValue +
//     ' TEXT)',
// 'CREATE TABLE ' +
//     TableChangeKey.tableName +
//     ' \(no INTEGER PRIMARY KEY AUTOINCREMENT, ' +
//     TableChangeKey.columnValue +
//     ' TEXT)',

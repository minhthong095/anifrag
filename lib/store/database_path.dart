import 'package:sqflite/sqflite.dart';

class DatabasePath {
  String _value;
  set value(String newValue) {}
  String get value => _value;

  DatabasePath() {
    getDatabasesPath().then((path) {
      _value = path;
    });
  }
}

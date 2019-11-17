import 'package:Anifrag/store/database_config.dart';

import '../app_db.dart';

class OfflineCategory {
  final AppDb _appDb;

  OfflineCategory(this._appDb);

  Future insertCategories(List<String> categories) async {
    final db = await _appDb.getDb();
    await db.transaction((txn) async {
      categories.forEach((category) async {
        await txn.rawInsert(
            'INSERT INTO ' +
                TableCategory.tableName +
                '(' +
                TableCategory.columnName +
                ') VALUES(?)',
            [category]);
      });
    });
    // await _appDb.closeDb();
  }

  List<String> queryCategories(List<String> categories) => categories
      .map<String>((c) =>
          'INSERT INTO ' +
          TableCategory.tableName +
          '(' +
          TableCategory.columnName +
          ') VALUES("' +
          c +
          '")')
      .toList();

  String queryDeleteAll() => 'DELETE FROM ' + TableCategory.tableName;
}

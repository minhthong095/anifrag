import 'package:Anifrag/model/responses/response_home_page_movie.dart';
import 'package:Anifrag/store/app_db.dart';
import 'package:Anifrag/store/database_config.dart';
import 'package:inject/inject.dart';

@provide
abstract class OfflineHomePageData {
  Future insertData(List<ResponseThumbnailMovie> homePageData);
  List<String> queryInsertThumbnail(List<ResponseThumbnailMovie> homePageData);
  String queryDeleteAll();
}

class ImplOfflineHomePageData extends OfflineHomePageData {
  final AppDb _appDb;

  ImplOfflineHomePageData(this._appDb);

  Future insertData(List<ResponseThumbnailMovie> homePageData) async {
    final db = await _appDb.db;
    await db.transaction((txn) async {
      homePageData.forEach((data) async {
        await txn.rawInsert(
            'INSERT INTO ' +
                TableThumnailMovie.tableName +
                '(' +
                TableThumnailMovie.columnIdMovie +
                ', ' +
                TableThumnailMovie.columnPosterPath +
                ') VALUES(?,?)',
            [data.id, data.posterPath]);
      });
    });
    // await _appDb.closeDb();
  }

  List<String> queryInsertThumbnail(List<ResponseThumbnailMovie> homePageData) {
    return homePageData
        .map<String>((d) =>
            'INSERT INTO ' +
            TableThumnailMovie.tableName +
            '(' +
            TableThumnailMovie.columnIdMovie +
            ', ' +
            TableThumnailMovie.columnPosterPath +
            ') VALUES(' +
            d.id.toString() +
            ',"' +
            d.posterPath +
            '")')
        .toList();
  }

  String queryDeleteAll() => 'DELETE FROM ' + TableThumnailMovie.tableName;
}

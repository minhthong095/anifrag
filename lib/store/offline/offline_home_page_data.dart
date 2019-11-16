import 'package:Anifrag/model/responses/response_home_page_movie.dart';
import 'package:Anifrag/store/app_db.dart';
import 'package:Anifrag/store/database_config.dart';

class OfflineHomePageData {
  final AppDb _appDb;

  OfflineHomePageData(this._appDb);

  Future insertData(List<ResponseThumbnailMovie> homePageData) async {
    final db = await _appDb.getDb();
    await db.transaction((txn) async {
      homePageData.forEach((data) async {
        await txn.rawInsert(
            'INSERT INTO ' +
                TableThumnailMovie.tableName +
                '(' +
                TableThumnailMovie.columnIdMovie +
                ', ' +
                TableThumnailMovie.columnPathPoster +
                ') VALUES(?,?)',
            [data.id, data.posterPath]);
      });
    });
    // await _appDb.closeDb();
  }
}

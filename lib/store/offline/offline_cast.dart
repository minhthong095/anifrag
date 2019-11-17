import 'package:Anifrag/model/responses/response_cast.dart';
import 'package:Anifrag/model/responses/response_home_page_movie.dart';
import 'package:Anifrag/store/app_db.dart';
import 'package:Anifrag/store/offline/offline_movie.dart';

import '../database_config.dart';

class OfflineCast {
  List<String> queryInsertCasts(List<ResponseCast> casts, int idMovie) => casts
      .map<String>((cast) =>
          'INSERT INTO ' +
          TableCast.tableName +
          '(' +
          TableCast.columnName +
          ', ' +
          TableCast.columnIdMovie +
          ') VALUES("' +
          cast.name +
          '", ' +
          idMovie.toString() +
          ')')
      .toList();

  String queryDeleteAllCastWithIdMovie(int idMovie) {
    return 'DELETE FROM ' +
        TableCast.tableName +
        ' WHERE ' +
        TableCast.columnIdMovie +
        ' = ' +
        idMovie.toString();
  }

  String querySelectCasts(int idMovie) {
    return 'SELECT * FROM ' +
        TableCast.tableName +
        ' WHERE ' +
        TableMovie.columnIdMovie +
        ' = ' +
        idMovie.toString();
    ;
  }
}

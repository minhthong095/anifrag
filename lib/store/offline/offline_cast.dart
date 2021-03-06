import 'package:Anifrag/model/responses/response_cast.dart';

import '../database_config.dart';

abstract class OfflineCast {
  List<String> queryInsertCasts(List<ResponseCast> casts, int idMovie);
  String queryDeleteAllCastWithIdMovie(int idMovie);
  String querySelectCasts(int idMovie);
}

class ImplOfflineCast extends OfflineCast {
  List<String> queryInsertCasts(List<ResponseCast> casts, int idMovie) => casts
      .map<String>((cast) =>
          'INSERT INTO ' +
          TableCast.tableName +
          '(' +
          TableCast.columnName +
          ', ' +
          TableCast.columnIdMovie +
          ') VALUES("' +
          cast.name.replaceAll('"', '""') +
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
  }
}

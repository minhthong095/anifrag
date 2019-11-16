import 'package:Anifrag/model/responses/response_cast.dart';
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
}

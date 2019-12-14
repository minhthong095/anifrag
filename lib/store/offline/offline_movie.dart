import 'package:Anifrag/model/responses/response_home_page_movie.dart';
import 'package:Anifrag/model/responses/response_movie.dart';
import 'package:Anifrag/store/app_db.dart';
import 'package:Anifrag/store/database_config.dart';
import 'package:sqflite/sqflite.dart';

abstract class OfflineMovie {
  String queryDeleteOneMovie(int idMovie);
  String queryInsertOneMovie(ResponseMovie movie);
  String querySelectMovie(int idMovie);
}

class ImplOfflineMovie extends OfflineMovie {
  String queryDeleteOneMovie(int idMovie) {
    return 'DELETE FROM ' +
        TableMovie.tableName +
        ' WHERE ' +
        TableMovie.columnIdMovie +
        ' = ' +
        idMovie.toString();
  }

  String queryInsertOneMovie(ResponseMovie movie) {
    final String releaseTimeStr = movie.releaseDate.year.toString() +
        '-' +
        movie.releaseDate.month.toString().padLeft(2, '0') +
        '-' +
        movie.releaseDate.day.toString().padLeft(2, '0') +
        ' 00:00:00';
    return 'INSERT INTO ' +
        TableMovie.tableName +
        '(' +
        TableMovie.columnIdMovie +
        ', ' +
        TableMovie.columnOverview +
        ', ' +
        TableMovie.columnRuntime +
        ', ' +
        TableMovie.columnPopularity +
        ', ' +
        TableMovie.columnTitle +
        ', ' +
        TableMovie.columnReleaseDate +
        ', ' +
        TableMovie.columnVoteAverage +
        ', ' +
        TableMovie.columnPosterPath +
        ', ' +
        TableMovie.columnVoteCount +
        ') VALUES(' +
        movie.id.toString() +
        ',"' +
        movie.overview.replaceAll('"', '""""') +
        '",' +
        movie.runtime.toString() +
        ',' +
        movie.popularity.toString() +
        ',"' +
        movie.title.replaceAll('"', '""') +
        '","' +
        releaseTimeStr +
        '",' +
        movie.voteAverage.toString() +
        ',"' +
        movie.posterPath.toString() +
        '",' +
        movie.voteCount.toString() +
        ')';
  }

  String querySelectMovie(int idMovie) {
    return 'SELECT * FROM ' +
        TableMovie.tableName +
        ' WHERE ' +
        TableMovie.columnIdMovie +
        ' = ' +
        idMovie.toString();
  }

  // final AppDb _appDb;

  // OfflineMovie(this._appDb);

  // // No need synchronous
  // void insertMovie(ResponseMovie movie) async {
  //   final Database db = await _appDb.getDb();
  //   // SELECT * FROM MOVIE WHERE strftime('%m', releasedate) = '08'
  //   String releaseTimeStr = movie.releaseDate.year.toString() +
  //       '-' +
  //       movie.releaseDate.month.toString().padLeft(2, '0') +
  //       '-' +
  //       movie.releaseDate.day.toString().padLeft(2, '0') +
  //       ' 00:00:00';
  //   db.rawInsert(
  //       'INSERT INTO ' +
  //           TableMovie.tableName +
  //           '(' +
  //           TableMovie.columnIdMovie +
  //           ', ' +
  //           TableMovie.columnOverview +
  //           ', ' +
  //           TableMovie.columnRuntime +
  //           ', ' +
  //           TableMovie.columnPopularity +
  //           ', ' +
  //           TableMovie.columnTitle +
  //           ', ' +
  //           TableMovie.columnReleaseDate +
  //           ', ' +
  //           TableMovie.columnVoteAverage +
  //           ', ' +
  //           TableMovie.columnVoteCount +
  //           ') VALUES(?,?,?,?,?,?,?,?)',
  //       [
  //         movie.id,
  //         movie.overview,
  //         movie.runtime,
  //         movie.popularity,
  //         movie.title,
  //         releaseTimeStr,
  //         movie.voteAverage,
  //         movie.voteCount
  //       ]);
  //   _appDb.closeDb();
  // }

}

import 'package:Anifrag/model/business/business_movie.dart';
import 'package:Anifrag/store/database_config.dart';

abstract class OfflineMovie {
  String queryDeleteOneMovie(int idMovie);
  String queryInsertOneMovie(BusinessMovie movie);
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

  String queryInsertOneMovie(BusinessMovie movie) {
    final String releaseTimeStr = movie.releaseDate.year.toString() +
        '-' +
        movie.releaseDate.month.toString().padLeft(2, '0') +
        '-' +
        movie.releaseDate.day.toString().padLeft(2, '0') +
        ' 00:00:00';

    return '''INSERT INTO ${TableMovie.tableName} (
      ${TableMovie.columnIdMovie},
      ${TableMovie.columnOverview},
      ${TableMovie.columnRuntime},
      ${TableMovie.columnPopularity},
      ${TableMovie.columnTitle},
      ${TableMovie.columnReleaseDate},
      ${TableMovie.columnVoteAverage},
      ${TableMovie.columnPosterPath},
      ${TableMovie.columnVoteCount},
      ${TableMovie.columnNumberOfSeasons},
      ${TableMovie.columnNumberOfEpisodes})
      VALUES 
      (${movie.id},
      "${movie.overview.replaceAll('"', '""""')}",
      ${movie.runtime},
      ${movie.popularity},
      "${movie.title.replaceAll('"', '""')}",
      "$releaseTimeStr",
      ${movie.voteAverage},
      "${movie.posterPath}",
      ${movie.voteCount},
      ${movie.numberOfSeasons},
      ${movie.numberOfEpisodes})
      ''';
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
  //   final Database db = await _appDb.db;
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

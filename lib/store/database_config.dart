class TablePosterSize {
  static const tableName = 'POSTER_SIZE';

  static const columnValue = 'value';
}

class TableChangeKey {
  static const String tableName = 'CHANGE_KEY';

  static const String columnValue = 'value';
}

class TableHomePageData {
  static const String tableName = 'HOME_PAGE_DATA';

  static const String columnIdMovie = 'idMovie';
  static const String columnPathPoster = 'pathPoster';
}

class TableCategory {
  static const String tableName = 'CATEGORY';

  static const String columnName = 'name';
}

class TableMovie {
  static const String tableName = "MOVIE";

  static const String columnIdMovie = 'idMovie';
  static const String columnTitle = 'title';
  static const String columnOverview = 'overview';
  static const String columnRuntime = 'runtim';
  static const String columnPopularity = 'popularity';
  static const String columnReleaseDate = 'releaseDate';
  static const String columnVoteAverage = 'voteAverate';
  static const String columnVoteCount = 'voteCount';
}

class TableCast {
  static const String tableName = 'CAST';

  static const String columnName = 'name';
  static const String columnIdMovie = 'idMovie';
}

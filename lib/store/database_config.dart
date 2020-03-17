class TablePosterSize {
  static const tableName = 'POSTER_SIZE';

  static const columnValue = 'value';
}

class TableChangeKey {
  static const String tableName = 'CHANGE_KEY';

  static const String columnValue = 'value';
}

class TableThumnailMovie {
  static const String tableName = 'THUMBNAIL_MOVIE';

  static const String columnIdMovie = 'id';
  static const String columnPosterPath = 'poster_path';
}

class TableCategory {
  static const String tableName = 'CATEGORY';

  static const String columnName = 'name';
}

/// Combine movie detail and tv show attributtes
class TableMovie {
  static const String tableName = "MOVIE";

  static const String columnIdMovie = 'id';
  static const String columnTitle = 'title';
  static const String columnOverview = 'overview';
  static const String columnRuntime = 'runtime';
  static const String columnPopularity = 'popularity';
  static const String columnReleaseDate = 'release_date';
  static const String columnVoteAverage = 'vote_average';
  static const String columnVoteCount = 'vote_count';
  static const String columnPosterPath = 'poster_path';
  static const String columnNumberOfSeasons = 'number_of_seasons';
  static const String columnNumberOfEpisodes = 'number_of_episodes';
}

class TableCast {
  static const String tableName = 'CAST';

  static const String columnName = 'name';
  static const String columnIdMovie = 'id';
}

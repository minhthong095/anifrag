abstract class Url {
  static const String baseUrl = "https://api.themoviedb.org/3";
  static const String baseUrlAbiary =
      "https://private-7eef3-anifrag.apiary-mock.com";

  String configuration;
  String categories;
  String trending;
  String searchMovies;
  String movieDetail(int idMovie);
  String movieCast(int idMovie);
  String moreLikeThis(int idMovie);
  String popularTvShow;
  String tvDetail(int idMovie);
}

class ImplUrl extends Url {
  @override
  String get searchMovies => "/search/movie";

  @override
  String get configuration => "/configuration";

  @override
  String get categories => "/categories";

  @override
  String get trending => "/trending/movie/day";

  @override
  String movieDetail(int idMovie) => "/movie/$idMovie";

  @override
  String movieCast(int idMovie) => "/movie/$idMovie/credits";

  @override
  String moreLikeThis(int idMovie) =>
      "/movie/" + idMovie.toString() + "/similar";

  @override
  String get popularTvShow => "/tv/popular";

  @override
  String tvDetail(int idMovie) {
    return '/tv/$idMovie';
  }
}

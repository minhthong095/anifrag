import 'package:inject/inject.dart';

abstract class AbsUrl {
  static const String baseUrl = "https://api.themoviedb.org/3";
  static const String baseUrlAbiary =
      "https://private-7eef3-anifrag.apiary-mock.com";

  String configuration;
  String categories;
  String trending;
  String movieDetail(int idMovie);
  String movieCast(int idMovie);
}

class Url extends AbsUrl {
  @override
  String configuration = "/configuration";

  @override
  String get categories => "/categories";

  @override
  String trending = "/trending/movie/day";

  @override
  String movieDetail(int idMovie) => "/movie/" + idMovie.toString();

  @override
  String movieCast(int idMovie) => "/movie/" + idMovie.toString() + "/credits";
}

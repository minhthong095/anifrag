import 'package:inject/inject.dart';

abstract class AbsUrl {
  static const String baseUrl = "https://api.themoviedb.org/3";
  static const String baseUrlAbiary =
      "https://private-7eef3-anifrag.apiary-mock.com";

  String configuration;
  String categories;
  String trending;
}

class Url extends AbsUrl {
  @override
  String configuration = "/configuration";

  @override
  String get categories => "/categories";

  @override
  String trending = "/trending/movie/day";
}

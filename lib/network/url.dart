import 'package:inject/inject.dart';

abstract class AbsUrl {
  String baseUrl;
  String configuration;
}

class Url extends AbsUrl {
  @override
  String baseUrl = "https://api.themoviedb.org/3";

  @override
  String configuration = "/configuration";
}

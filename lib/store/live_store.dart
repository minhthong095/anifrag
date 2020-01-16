import 'dart:collection';

import 'package:Anifrag/model/responses/response_configuration.dart';
import 'package:Anifrag/model/responses/response_home_page_movie.dart';
import 'package:Anifrag/model/responses/response_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LiveStore {
  ResponseConfiguration _responseConfiguration;
  ResponseConfiguration get getResponseConfiguration => _responseConfiguration;
  set setResponseConfiguration(ResponseConfiguration value) =>
      _responseConfiguration = value;

  List<String> _categories;
  List<String> get getCategories => _categories;
  set setCategories(List<String> value) => _categories = value;

  List<ResponseThumbnailMovie> _homePageData;
  List<ResponseThumbnailMovie> get getHomePageData => _homePageData;
  set setHomePageData(List<ResponseThumbnailMovie> value) =>
      _homePageData = value;

  SplayTreeMap<String, List<ResponseSearch>> _searchHistory =
      SplayTreeMap<String, List<ResponseSearch>>();
  SplayTreeMap<String, List<ResponseSearch>> get getSearchHistory =>
      _searchHistory;

  static const int widthImgApi = 300; // pixel
  static const int heightImgApi = 450; // pixel
  static const double ratioImgApi = widthImgApi / heightImgApi;

  static const double tempHardCodeAspectRatio = 2 / 3;

  String get baseUrlImage {
    if (_responseConfiguration == null ||
        _responseConfiguration.images == null ||
        _responseConfiguration.images.secureBaseUrl == null) return '';

    return _responseConfiguration.images.secureBaseUrl + '/w400';
  }
}

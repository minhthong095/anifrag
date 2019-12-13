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
  // set setSearchHistory(HashMap<String, List<ResponseSearch>> value) =>
  //     _searchHistory = value;

  static const int widthImgApi = 300; // pixel
  static const int heightImgApi = 450; // pixel
  static const double ratioImgApi = widthImgApi / heightImgApi;

  // static const double tempHardCodeAspectRatio = 85.7142857143 / 128.5714285714;
  static const double tempHardCodeAspectRatio = 2 / 3;
  // static const double tempHardCodeAspectRatio = 85.7142857143 / 128.5714285714;

  // double _widthImgDpApi = 0;
  // get getWidthImgDpApi => _widthImgDpApi;
  // set setWidthImgDbApi(double widthDp) {
  //   _widthImgDpApi = widthDp;
  // }

  // double _heightImgDpApi = 0;
  // get getHeightImgDpApi => _heightImgDpApi;
  // set setHeightImgDbApi(double heightDp) {
  //   _heightImgDpApi = heightDp;
  // }

  String get baseUrlImage {
    if (_responseConfiguration == null ||
        _responseConfiguration.images == null ||
        _responseConfiguration.images.secureBaseUrl == null) return '';

    return _responseConfiguration.images.secureBaseUrl;
  }
}

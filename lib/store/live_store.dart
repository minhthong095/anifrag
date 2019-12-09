import 'package:Anifrag/model/responses/response_configuration.dart';
import 'package:Anifrag/model/responses/response_home_page_movie.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LiveStore {
  ResponseConfiguration responseConfiguration;
  List<String> categories;
  List<ResponseThumbnailMovie> homePageData;

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
    if (responseConfiguration == null ||
        responseConfiguration.images == null ||
        responseConfiguration.images.secureBaseUrl == null) return '';

    return responseConfiguration.images.secureBaseUrl;
  }
}

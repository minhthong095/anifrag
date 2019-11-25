import 'package:Anifrag/model/responses/response_configuration.dart';
import 'package:Anifrag/model/responses/response_home_page_movie.dart';
import 'package:flutter/foundation.dart';

class LiveStore {
  ResponseConfiguration responseConfiguration;
  List<String> categories;
  List<ResponseThumbnailMovie> homePageData;

  String get baseUrlImage {
    if (responseConfiguration == null ||
        responseConfiguration.images == null ||
        responseConfiguration.images.secureBaseUrl == null) return '';

    return responseConfiguration.images.secureBaseUrl;
  }
}

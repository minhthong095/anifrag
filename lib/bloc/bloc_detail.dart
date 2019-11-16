import 'package:Anifrag/model/responses/response_cast.dart';
import 'package:Anifrag/model/responses/response_movie.dart';
import 'package:Anifrag/store/live_store.dart';
import 'package:Anifrag/store/offline/offline_movie.dart';
import 'package:flutter/material.dart';

class BlocDetail {
  final OfflineMovie offlineMovie;
  final LiveStore liveStore;

  ResponseMovie movie;
  List<ResponseCast> casts;
  String tagPrefix;

  BlocDetail(this.offlineMovie, this.liveStore);

  String posterPath() =>
      liveStore.responseConfiguration.images.secureBaseUrl + movie.posterPath;
}

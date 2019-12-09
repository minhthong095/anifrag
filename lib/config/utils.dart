import 'package:Anifrag/store/live_store.dart';
import 'package:flutter/material.dart';

class Utils {
  static double getWidthDpImgApi(BuildContext context) =>
      LiveStore.widthImgApi / MediaQuery.of(context).devicePixelRatio;
  static double getHeightDpImgApi(BuildContext context) =>
      LiveStore.heightImgApi / MediaQuery.of(context).devicePixelRatio;
}

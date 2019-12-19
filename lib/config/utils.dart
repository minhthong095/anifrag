import 'package:Anifrag/store/live_store.dart';
import 'package:flutter/material.dart';

class Utils {
  static double getWidthDpImgApi(BuildContext context) =>
      LiveStore.widthImgApi / MediaQuery.of(context).devicePixelRatio;

  static double getHeightDpImgApi(BuildContext context) =>
      LiveStore.heightImgApi / MediaQuery.of(context).devicePixelRatio;

  static double widthInRatio(double height, double ratio) => height * ratio;

  static double heightInRatio(double width, double ratio) => width / ratio;

  static String generateStringRuntime(int runtime) {
    if (runtime == 0) return '';

    return (runtime / 60).toStringAsFixed(0) +
        'h ' +
        (runtime % 60).toStringAsFixed(0) +
        'min';
  }
}

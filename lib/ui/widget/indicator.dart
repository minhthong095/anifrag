import 'dart:io';

import 'package:Anifrag/config/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS)
      return CupertinoActivityIndicator(
        radius: 12,
      );

    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(AppColor.yellow),
    );
  }
}

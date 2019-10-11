import 'package:Anifrag/screen/detail.dart';
import 'package:flutter/material.dart';

class DetailTransition extends PageRouteBuilder {
  DetailTransition({@required imagePath})
      : super(
          transitionDuration: Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondAnimation) => Detail(
            transitionAnimation: animation,
            imagePath: imagePath,
          ),
        );
}

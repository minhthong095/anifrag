import 'package:Anifrag/screen/detail.dart';
import 'package:flutter/material.dart';

class DetailTransition extends PageRouteBuilder {
  DetailTransition({@required imagePath, @required tagPrefix})
      : super(
          transitionDuration: Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondAnimation) => Detail(
            tagPrefix: tagPrefix,
            imagePath: imagePath,
          ),
        );

  // For no animation, both in and out.
  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }
}

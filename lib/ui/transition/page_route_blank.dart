import 'package:Anifrag/ui/screen/detail.dart';
import 'package:flutter/material.dart';

class PageRouteBlank extends PageRouteBuilder {
  PageRouteBlank(
      {@required DetailScreen child, @required RouteSettings routeSettings})
      : super(
            settings: routeSettings,
            transitionDuration: Duration(milliseconds: 300),
            pageBuilder: (context, animation, secondAnimation) => child);

  // // For no animation, both in and out.
  // @override
  // Widget buildTransitions(BuildContext context, Animation<double> animation,
  //     Animation<double> secondaryAnimation, Widget child) {
  //   return child;
  // }
}

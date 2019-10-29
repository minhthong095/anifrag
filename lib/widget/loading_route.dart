import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/config/path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lottie/flutter_lottie.dart';

class LoadingRoute extends PopupRoute {
  static const String nameRoute = '/loading';

  @override
  Color get barrierColor => Colors.black.withOpacity(0.2);

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => '';

  @override
  bool get maintainState => false;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Center(
      child: SizedBox(
        width: 75,
        height: 75,
        child: Container(
          decoration: BoxDecoration(
              color: AppColor.yellow,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: LottieView.fromFile(
              filePath: PathLottie.loading,
              autoPlay: true,
              loop: true,
              onViewCreated: (controller) {}),
        ),
      ),
    );
  }

  @override
  Duration get transitionDuration => Duration(seconds: 0);
}

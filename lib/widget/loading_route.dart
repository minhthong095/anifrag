import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/config/path.dart';
import 'package:Anifrag/screen/detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lottie/flutter_lottie.dart';

class LoadingRoute extends PopupRoute {
  static const String nameRoute = '/loading';

  @override
  Color get barrierColor => Colors.black.withOpacity(0.2);

  @override
  bool get barrierDismissible => false;

  @override
  String get barrierLabel => '';

  @override
  bool get maintainState => false;

  @override
  RouteSettings get settings => RouteSettings(name: nameRoute);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    // return Center(
    //   child: SizedBox(
    //     width: 75,
    //     height: 75,
    //     child: GestureDetector(
    //       onTap: () {
    //         Navigator.of(context)
    //             .popUntil(ModalRoute.withName(Detail.nameRoute));
    //       },
    //       child: Container(
    //         decoration: BoxDecoration(
    //             color: AppColor.yellow,
    //             borderRadius: BorderRadius.all(Radius.circular(10))),
    //         child: LottieView.fromFile(
    //             filePath: PathLottie.loading,
    //             autoPlay: true,
    //             loop: true,
    //             onViewCreated: (controller) {}),
    //       ),
    //     ),
    //   ),
    // );

    return MaterialApp(
      home: GestureDetector(
        onTap: () {
          // print("A");
          // Navigator.of(context).popUntil(ModalRoute.withName(Detail.nameRoute));
          // // Navigator.of(context).pop(); // success
          // final a = ModalRoute.withName(Detail.nameRoute);
          // print("HA");
          // Navigator.of(context).pop();
          Navigator.of(context)
              .popUntil((ModalRoute.withName(Detail.nameRoute)));
        },
        child: Container(
          color: Colors.red,
        ),
      ),
    );
  }

  @override
  Duration get transitionDuration => Duration(seconds: 0);
}

import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/config/path.dart';
import 'package:Anifrag/ui/screen/detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lottie/flutter_lottie.dart';

class LoadingRoute extends PopupRoute {
  static const String nameRoute = '/loading';
  static bool isWillPop = false;

  @override
  Color get barrierColor => Colors.white.withOpacity(0);

  @override
  bool get barrierDismissible => false;

  @override
  String get barrierLabel => '';

  @override
  RouteSettings get settings => RouteSettings(name: nameRoute);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return _AnimateLoading();
  }

  @override
  Duration get transitionDuration => Duration(seconds: 0);

  // pop loading route from outside
  // isWillPop turn back to normal when AnimateLoading disposed
  static RoutePredicate loadingRoutePredicate() => (Route<dynamic> route) {
        isWillPop = true;
        return !route.willHandlePopInternally &&
            route is ModalRoute &&
            route.settings.name != nameRoute &&
            isWillPop;
      };
}

class _AnimateLoading extends StatefulWidget {
  @override
  _AnimateLoadingState createState() => _AnimateLoadingState();
}

class _AnimateLoadingState extends State<_AnimateLoading>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 300), upperBound: 0.6);
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    LoadingRoute.isWillPop = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget child) => Container(
        color: Colors.black.withOpacity(_controller.value),
        child: Center(
          child: SizedBox(
            width: 75,
            height: 75,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .popUntil(ModalRoute.withName(Detail.nameRoute));
              },
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
          ),
        ),
      ),
    );
  }
}

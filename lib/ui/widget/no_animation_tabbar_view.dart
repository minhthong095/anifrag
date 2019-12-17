import 'dart:async';

import 'package:Anifrag/bloc/bloc_maintab_bar.dart';
import 'package:Anifrag/config/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'no_connection_popup.dart';

class NoAnimationTabBarView extends StatefulWidget {
  final List<Widget> children;
  final TabController tabController;

  const NoAnimationTabBarView({
    @required this.children,
    @required this.tabController,
  });

  @override
  _NoAnimationTabbarView createState() => _NoAnimationTabbarView();
}

// Old version before change using PageView place before this commit 6a2f2d7344bc47b6528bde8557862ce053a786a1
class _NoAnimationTabbarView extends State<NoAnimationTabBarView>
    with SingleTickerProviderStateMixin {
  static const double _heightPopupWifi = 70;

  AnimationController _popupController;
  Function _listener;
  Animation _animationPopup;
  BlocMainTabbar _blocMainTabbar;
  Duration _timeDuration;
  PageController _pageController;

  @override
  void initState() {
    _initOnTapTabbar();
    _initPopupAnimationController();
    _initPageController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _initPopupSubscription();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _popupController
        .removeStatusListener(_popupAnimationControllerStatusListener);
    widget.tabController.removeListener(_listener);
    _blocMainTabbar.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _initPageController() {
    _pageController = PageController(
      initialPage: 0,
    );
  }

  void _initPopupSubscription() {
    _blocMainTabbar = Provider.of<BlocMainTabbar>(context, listen: false);
    _blocMainTabbar.subjectPopup.stream
        .where(
            (duration) => _popupController.status == AnimationStatus.dismissed)
        .listen((duration) {
      _timeDuration = duration;
      _popupController.forward();
    });
  }

  void _popupAnimationControllerStatusListener(AnimationStatus status) async {
    if (status == AnimationStatus.completed) {
      await Future.delayed(_timeDuration, () {});
      _popupController.reverse();
    }
  }

  void _initPopupAnimationController() {
    _popupController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _popupController.addStatusListener(_popupAnimationControllerStatusListener);
    _animationPopup = Tween<double>(begin: -_heightPopupWifi, end: 0)
        .chain(CurveTween(curve: Curves.easeOutExpo))
        .animate(_popupController);
  }

  void _initOnTapTabbar() {
    _listener = () {
      if (widget.tabController.indexIsChanging) {
        _pageController.animateToPage(widget.tabController.index,
            curve: Curves.linear, duration: Duration(microseconds: 1));
      }
    };
    widget.tabController.addListener(_listener);
  }

  @override
  Widget build(BuildContext context) => Stack(
        children: <Widget>[
          PageView(
            controller: _pageController,
            children: widget.children,
          ),
          AnimatedBuilder(
              animation: _animationPopup,
              child: NoConnectionPopup(),
              builder: (BuildContext context, Widget child) {
                return Positioned(
                  right: 0,
                  left: 0,
                  height: _heightPopupWifi,
                  bottom: _animationPopup.value,
                  child: child,
                );
              })
        ],
      );

// @override
// Widget build(BuildContext context) => Container(color: Colors.red);
}

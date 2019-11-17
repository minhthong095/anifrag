import 'dart:async';

import 'package:Anifrag/config/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'no_connection_popup.dart';

class NoAnimationTabBarView extends StatefulWidget {
  final List<Widget> children;
  final TabController tabController;

  const NoAnimationTabBarView(
      {@required this.children, @required this.tabController});

  @override
  _NoAnimationTabbarView createState() => _NoAnimationTabbarView();
}

class _NoAnimationTabbarView extends State<NoAnimationTabBarView>
    with SingleTickerProviderStateMixin {
  final _streamControllerIndex = StreamController<int>();

  static const double _heightPopupWifi = 70;

  AnimationController _controller;
  Function _listener;
  Animation _animationPopup;

  @override
  void initState() {
    _initOnTap();
    _initAnimationController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeStatusListener(_animationControllerStatusListener);
    _streamControllerIndex.close();
    widget.tabController.removeListener(_listener);
    super.dispose();
  }

  void _animationControllerStatusListener(AnimationStatus status) async {
    if (status == AnimationStatus.completed) {
      await Future.delayed(const Duration(milliseconds: 1100), () {});
      _controller.reverse();
    }
  }

  void _initAnimationController() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _controller.addStatusListener(_animationControllerStatusListener);
    _animationPopup = Tween<double>(begin: -_heightPopupWifi, end: 0)
        .chain(CurveTween(curve: Curves.easeOutExpo))
        .animate(_controller);
  }

  void _initOnTap() {
    _listener = () {
      if (widget.tabController.indexIsChanging) {
        // _streamControllerIndex.add(widget.tabController.index);
        print(_controller.status.toString());
        if (_controller.status == AnimationStatus.dismissed)
          _controller.forward();
      }
    };
    widget.tabController.addListener(_listener);
  }

  @override
  Widget build(BuildContext context) => StreamBuilder(
        stream: _streamControllerIndex.stream,
        builder: (context, AsyncSnapshot<int> snapshot) {
          final index = snapshot.data ?? 0;
          return Stack(
            children: <Widget>[
              Stack(
                children: widget.children.map((child) {
                  return Visibility(
                    visible: index == widget.children.indexOf(child),
                    child: widget.children[index],
                  );
                }).toList(),
              ),
              AnimatedBuilder(
                  animation: _animationPopup,
                  builder: (BuildContext context, Widget child) {
                    return Positioned(
                      right: 0,
                      left: 0,
                      height: _heightPopupWifi,
                      bottom: _animationPopup.value,
                      child: NoConnectionPopup(),
                    );
                  })
            ],
          );
        },
      );

  // @override
  // Widget build(BuildContext context) => Container(color: Colors.red);
}

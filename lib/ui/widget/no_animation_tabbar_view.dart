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
  BlocMainTabbar _blocMainTabbar;
  Duration _timeDuration;

  @override
  void initState() {
    _initOnTapTabbar();
    _initAnimationController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _initPopupSubscription();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.removeStatusListener(_animationControllerStatusListener);
    _streamControllerIndex.close();
    widget.tabController.removeListener(_listener);
    _blocMainTabbar.dispose();
    super.dispose();
  }

  void _initPopupSubscription() {
    _blocMainTabbar = Provider.of<BlocMainTabbar>(context);
    _blocMainTabbar.subjectPopup.stream
        .where((duration) => _controller.status == AnimationStatus.dismissed)
        .listen((duration) {
      _timeDuration = duration;
      _controller.forward();
    });
  }

  void _animationControllerStatusListener(AnimationStatus status) async {
    if (status == AnimationStatus.completed) {
      await Future.delayed(_timeDuration, () {});
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

  void _initOnTapTabbar() {
    _listener = () {
      if (widget.tabController.indexIsChanging) {
        _streamControllerIndex.add(widget.tabController.index);
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
        },
      );

  // @override
  // Widget build(BuildContext context) => Container(color: Colors.red);
}

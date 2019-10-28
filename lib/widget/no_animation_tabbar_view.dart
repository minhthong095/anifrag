import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoAnimationTabBarView extends StatefulWidget {
  final List<Widget> children;
  // final Function onTap;
  final TabController tabController;

  // const NoAnimationTabBarView({@required this.children, @required this.onTap});
  const NoAnimationTabBarView(
      {@required this.children, @required this.tabController});

  @override
  _NoAnimationTabbarView createState() => _NoAnimationTabbarView();
}

class _NoAnimationTabbarView extends State<NoAnimationTabBarView> {
  int index = 0;

  final _streamControllerIndex = StreamController<int>();
  Sink<int> _sinkIndex;
  Function _listener;

  @override
  void initState() {
    _initStreams();
    _initOnTap();
    super.initState();
  }

  @override
  void dispose() {
    widget.tabController.removeListener(_listener);
    super.dispose();
  }

  void _initStreams() {
    _sinkIndex = _streamControllerIndex.sink;
  }

  void _initOnTap() {
    _listener = () {
      if (widget.tabController.indexIsChanging)
        _sinkIndex.add(widget.tabController.index);
    };
    widget.tabController.addListener(_listener);
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: StreamBuilder(
          stream: _streamControllerIndex.stream,
          builder: (context, AsyncSnapshot<int> snapshot) {
            return Column(
              children: widget.children.map((child) {
                return Text(snapshot.data.toString());
              }).toList(),
            );
          },
        ),
      );

  // @override
  // Widget build(BuildContext context) => Container(color: Colors.red);
}

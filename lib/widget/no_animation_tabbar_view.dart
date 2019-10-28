import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoAnimationTabBarView extends StatefulWidget {
  final List<Widget> children;
  final TabController tabController;

  const NoAnimationTabBarView(
      {@required this.children, @required this.tabController});

  @override
  _NoAnimationTabbarView createState() => _NoAnimationTabbarView();
}

class _NoAnimationTabbarView extends State<NoAnimationTabBarView> {
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
  Widget build(BuildContext context) => StreamBuilder(
        stream: _streamControllerIndex.stream,
        builder: (context, AsyncSnapshot<int> snapshot) {
          final index = snapshot.data ?? 0;
          return Stack(
            children: widget.children.map((child) {
              return Visibility(
                visible: index == widget.children.indexOf(child),
                child: widget.children[index],
              );
            }).toList(),
          );
        },
      );

  // @override
  // Widget build(BuildContext context) => Container(color: Colors.red);
}

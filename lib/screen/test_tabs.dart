import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TestTab extends StatefulWidget {
  @override
  _TestTab createState() => _TestTab();
}

class _TestTab extends State<TestTab> with SingleTickerProviderStateMixin {
  final List<Tab> tabs = <Tab>[
    Tab(
      text: "MORE LIKE THIS",
    ),
    Tab(
      text: "OVERVIEW",
    ),
  ];

  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: tabs.length);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Theme(
          data: ThemeData(splashFactory: NoSplashFactory()),
          child: TabBar(
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.label,
            controller: _tabController,
            tabs: tabs,
          ),
        ),
      );
}

class NoSplashFactory extends InteractiveInkFeatureFactory {
  const NoSplashFactory();

  @override
  InteractiveInkFeature create(
      {MaterialInkController controller,
      RenderBox referenceBox,
      Offset position,
      Color color,
      TextDirection textDirection,
      bool containedInkWell = false,
      rectCallback,
      BorderRadius borderRadius,
      ShapeBorder customBorder,
      double radius,
      onRemoved}) {
    return new NoSplash(
      controller: controller,
      referenceBox: referenceBox,
    );
  }
}

class NoSplash extends InteractiveInkFeature {
  NoSplash({
    @required MaterialInkController controller,
    @required RenderBox referenceBox,
  })  : assert(controller != null),
        assert(referenceBox != null),
        super(
          controller: controller,
          referenceBox: referenceBox,
        );

  @override
  void paintFeature(Canvas canvas, Matrix4 transform) {}
}

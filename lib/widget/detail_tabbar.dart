import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/widget/more_like_this.dart';
import 'package:Anifrag/widget/story_overview.dart';
import 'package:Anifrag/widget/tab_bar_remove_center.dart' as custom;
import 'package:flutter/material.dart';

class DetailTabbar extends StatefulWidget {
  @override
  _DetailTabbar createState() => _DetailTabbar();
}

class _DetailTabbar extends State<DetailTabbar>
    with SingleTickerProviderStateMixin {
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
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Positioned(
                bottom: 0,
                height: 2,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.grey[200],
                ),
              ),
              Theme(
                data: ThemeData(splashFactory: NoSplashFactory()),
                child: custom.TabBarRemoveAlignment(
                  labelPadding: EdgeInsets.zero,
                  indicatorColor: AppColor.yellow,
                  indicatorPadding: EdgeInsets.only(right: 100),
                  labelStyle: TextStyle(fontWeight: FontWeight.w600),
                  labelColor: AppColor.yellow,
                  unselectedLabelColor: Colors.grey,
                  controller: _tabController,
                  tabs: tabs,
                ),
              )
            ],
          ),
          SizedBox.fromSize(
            size: Size(0, 20),
          ),
          AnimatedBuilder(
            animation: _tabController,
            builder: (context, widget) {
              return Stack(
                children: <Widget>[
                  Visibility(
                    visible: _tabController.index == 0 ? true : false,
                    child: MoreLikeThis(),
                  ),
                  Visibility(
                    // If choose Opacity widget, the gridview in MoreLikeThis will hard to scroll.
                    visible: _tabController.index == 1 ? true : false,
                    child: StoryOverview(),
                  )
                ],
              );
            },
          )
        ],
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

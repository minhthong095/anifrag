import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/ui/widget/more_like_this.dart';
import 'package:Anifrag/ui/widget/story_overview.dart';
import 'package:Anifrag/ui/widget/tab_bar_remove_center.dart' as custom;
import 'package:flutter/material.dart';

import 'no_splash_factory.dart';

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
                  color: Colors.grey,
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
                  unselectedLabelColor: Colors.white,
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

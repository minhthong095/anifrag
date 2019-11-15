import 'package:Anifrag/bloc/bloc_home.dart';
import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/config/path.dart';
import 'package:Anifrag/ui/screen/home.dart';
import 'package:Anifrag/ui/screen/search.dart';
import 'package:Anifrag/ui/widget/no_animation_tabbar_view.dart';
import 'package:Anifrag/ui/widget/no_splash_factory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainTabBar extends StatefulWidget {
  static const String nameRoute = '/mainTabBar';

  @override
  _MainTabBarState createState() => _MainTabBarState();
}

class _MainTabBarState extends State<MainTabBar> with TickerProviderStateMixin {
  TabController _tabController;
  final List<String> _tabsSvg = <String>[PathSvg.home, PathSvg.find];

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: _tabsSvg.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: NoAnimationTabBarView(
          tabController: _tabController,
          children: <Widget>[Home(), Search()],
        ),
        bottomNavigationBar: TabBarSvg(
          tabController: _tabController,
          onTap: (newIndex) {},
          children: <String>[PathSvg.home, PathSvg.find],
        ),
      );
}

class TabBarSvg extends StatefulWidget {
  final List<String> children;
  final Color color;
  final Color unselectedColor;
  final Color backgroundColor;
  final Function onTap;
  final TabController tabController;

  const TabBarSvg(
      {@required this.children,
      this.color = AppColor.yellow,
      @required this.tabController,
      @required this.onTap,
      this.unselectedColor = Colors.white70,
      this.backgroundColor = AppColor.backgroundColor});

  @override
  State<StatefulWidget> createState() => _TestTab();
}

class _TestTab extends State<TabBarSvg> with TickerProviderStateMixin {
  int _index = 0;

  final double _size = 25;

  @override
  Widget build(BuildContext context) => Theme(
        data: ThemeData(splashFactory: NoSplashFactory()),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              constraints: BoxConstraints.expand(height: 1),
              color: Colors.grey,
            ),
            Container(
              color: widget.backgroundColor,
              child: TabBar(
                onTap: (newIndex) {
                  widget.onTap(newIndex);
                  setState(() {
                    _index = newIndex;
                  });
                },
                indicatorColor: Colors.transparent,
                labelColor: Colors.yellow,
                controller: widget.tabController,
                tabs: widget.children.map((child) {
                  return Tab(
                    icon: SizedBox.fromSize(
                      size: Size(_size, _size),
                      child: SvgPicture.asset(
                        child,
                        color: widget.children.indexOf(child) == _index
                            ? widget.color
                            : widget.unselectedColor,
                      ),
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      );
}

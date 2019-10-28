import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/config/path.dart';
import 'package:Anifrag/screen/home.dart';
import 'package:Anifrag/widget/no_splash_factory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TestTabSceen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Home(),
        bottomNavigationBar: TestTab(
          onTap: (newIndex) {},
          children: <String>[PathSvg.home, PathSvg.find],
        ),
      );
}

class TestTab extends StatefulWidget {
  final List<String> children;
  final Color color;
  final Color unselectedColor;
  final Color backgroundColor;
  final Function onTap;

  const TestTab(
      {@required this.children,
      this.color = AppColor.yellow,
      @required this.onTap,
      this.unselectedColor = Colors.white70,
      this.backgroundColor = AppColor.backgroundColor});

  @override
  State<StatefulWidget> createState() => _TestTab();
}

class _TestTab extends State<TestTab> with TickerProviderStateMixin {
  TabController tabController;
  int _index = 0;

  @override
  void initState() {
    tabController = TabController(vsync: this, length: widget.children.length);
    super.initState();
  }

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
                controller: tabController,
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

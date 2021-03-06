import 'package:Anifrag/bloc/bloc_home.dart';
import 'package:Anifrag/bloc/bloc_maintab_bar.dart';
import 'package:Anifrag/bloc/bloc_search_detail.dart';
import 'package:Anifrag/bloc/bloc_search_view.dart';
import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/config/app_icons_icons.dart';
import 'package:Anifrag/model/responses/response_home_page_movie.dart';
import 'package:Anifrag/ui/screen/home.dart';
import 'package:Anifrag/ui/screen/search.dart';
import 'package:Anifrag/ui/widget/no_splash_factory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MainTabBarScreen extends StatelessWidget {
  static const String nameRoute = '/mainTabBar';

  final BlocHome blocHome;
  final BlocMainTabbar blocMainTabbar;
  final BlocSearchDetail blocSearchDetail;
  final BlocSearchView blocSearchView;

  MainTabBarScreen(this.blocHome, this.blocMainTabbar, this.blocSearchDetail,
      this.blocSearchView);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<BlocHome>.value(value: blocHome),
        Provider<BlocMainTabbar>(
          create: (ctx) => blocMainTabbar,
          dispose: (_, bloc) => bloc.dispose(),
        )
      ],
      child: _MainTabBarScreen(this.blocSearchDetail, this.blocSearchView),
    );
  }
}

class _MainTabBarScreen extends StatefulWidget {
  final BlocSearchDetail blocSearchDetail;
  final BlocSearchView blocSearchView;

  _MainTabBarScreen(this.blocSearchDetail, this.blocSearchView);

  @override
  _MainTabBarScreenState createState() => _MainTabBarScreenState();
}

class _MainTabBarScreenState extends State<_MainTabBarScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: AppColor.backgroundColor,
        activeColor: AppColor.yellow,
        inactiveColor: Colors.white70,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
            Icons.home,
            size: 35,
          )),
          BottomNavigationBarItem(icon: Icon(AppIcon.search))
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return Home();
            break;
          case 1:
            return SearchScreen(widget.blocSearchDetail, widget.blocSearchView);
            break;
        }
        return null;
      },
    );

    // return Scaffold(
    //   body: NoAnimationTabBarView(
    //     tabController: _tabController,
    //     children: <Widget>[Home(), widget.searchScreen],
    //   ),
    //   bottomNavigationBar: TabBarSvg(
    //     tabController: _tabController,
    //     onTap: (newIndex) {},
    //     children: <String>[PathSvg.home, PathSvg.find],
    //   ),
    // );
  }
}

class MainTabBarScreenArgs {
  final Map<String, List<ResponseThumbnailMovie>> homePageData;

  const MainTabBarScreenArgs(this.homePageData);
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

  final double _size = 30;

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
              padding: EdgeInsets.only(top: 7, bottom: 7),
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

class MainTabBarArg {
  final List<String> categories;
  final List<ResponseThumbnailMovie> homePageData;
  final Map<String, List<ResponseThumbnailMovie>> tvShowData;
  MainTabBarArg(this.categories, this.homePageData, this.tvShowData);
}

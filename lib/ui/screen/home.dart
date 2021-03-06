import 'dart:io';

import 'package:Anifrag/bloc/bloc_home.dart';
import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/ui/mixin/mixin_move_detail.dart';
import 'package:Anifrag/ui/widget/list_image_home.dart';
import 'package:Anifrag/ui/widget/the_carousel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

// TODO: Consider remove provider
class Home extends StatefulWidget {
  @override
  $Home createState() => $Home();
}

typedef OnItemTap = void Function(int idMovie, String prefix, bool isTv);

class $Home extends State<Home>
    with AutomaticKeepAliveClientMixin<Home>, MoveDetailMixin {
  static final double paddingInHome = 20;

  BlocHome _blocHome;
  OnItemTap _onItemTap;

  @override
  void didChangeDependencies() {
    _initBlocHome();
    _initOnItemTap();
    initListenerMoveToDetailState(context, _blocHome);
    super.didChangeDependencies();
  }

  void _initOnItemTap() {
    _onItemTap = (int idMovie, String prefix, bool isTv) {
      _blocHome.moveDetailProcess(idMovie, prefix, isTv);
    };
  }

  void _initBlocHome() {
    _blocHome = Provider.of<BlocHome>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: Platform.isIOS
                        ? EdgeInsets.only(left: paddingInHome)
                        : EdgeInsets.only(left: paddingInHome, top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _blocHome.getMainCategory,
                          style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 20),
                          child: Text(
                            "Trending movies today",
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Provider<OnItemTap>(
              create: (context) => _onItemTap,
              child: TheCarousel(),
            ),
            for (String categoryTitle in _blocHome.getListRestMovies.keys)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _CategoryTitle(
                    title: categoryTitle,
                  ),
                  Provider<OnItemTap>(
                    create: (context) => _onItemTap,
                    child: ListImageHome(
                      onItemTap: _onItemTap,
                      baseUrlImg: _blocHome.baseUrlImage,
                      heroTagPrefix: categoryTitle,
                      padding: EdgeInsets.only(left: paddingInHome),
                      listHomePageMovie:
                          _blocHome.getListRestMovies[categoryTitle],
                    ),
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _CategoryTitle extends StatelessWidget {
  final String title;

  const _CategoryTitle({@required this.title});

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(left: $Home.paddingInHome, top: 25, bottom: 7),
        child: Text(
          this.title,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      );
}

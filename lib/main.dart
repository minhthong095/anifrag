import 'package:Anifrag/bloc/bloc_carousel.dart';
import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/config/path_image.dart';
import 'package:Anifrag/widget/hero_image.dart';
import 'package:Anifrag/widget/list_image_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'config/mock_data.dart';
import 'screen/detail.dart';
import 'screen/the_carousel.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white, // Color for Android
      statusBarBrightness:
          Brightness.dark // Dark == white status bar -- for IOS.
      ));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(backgroundColor: AppColor.backgroundColor, body: Home()),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Provider<BlocCarousel>(
        builder: (context) => BlocCarousel(),
        dispose: (context, value) => value.dispose(),
        child: $Home(),
      );
}

class $Home extends StatefulWidget {
  @override
  $$Home createState() => $$Home();
}

class $$Home extends State<$Home> {
  static final double paddingInHome = 20;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate([
            SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: paddingInHome),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Most search",
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
            TheCarousel(),
            _CategoryTitle(
              title: 'Popuar',
            ),
            ListImageHome(
              padding: EdgeInsets.only(left: paddingInHome),
              listImagePath: MockData.listImage,
            ),
            _CategoryTitle(
              title: 'Actions',
            ),
            ListImageHome(
              padding: EdgeInsets.only(left: paddingInHome),
              listImagePath: MockData.listImage,
            ),
            _CategoryTitle(
              title: 'Drama',
            ),
            ListImageHome(
              padding: EdgeInsets.only(left: paddingInHome),
              listImagePath: MockData.listImage,
            )
          ]),
        )
      ],
    );
  }
}

class _CategoryTitle extends StatelessWidget {
  final String title;

  const _CategoryTitle({@required this.title});

  @override
  Widget build(BuildContext context) => Padding(
        padding:
            EdgeInsets.only(left: $$Home.paddingInHome, top: 15, bottom: 15),
        child: Text(
          this.title,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      );
}

import 'dart:io';

import 'package:Anifrag/bloc/bloc_home.dart';
import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/config/mock_data.dart';
import 'package:Anifrag/ui/widget/the_carousel.dart';
import 'package:Anifrag/ui/widget/list_image_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  $Home createState() => $Home();
}

class $Home extends State<Home> {
  static final double paddingInHome = 20;

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
              title: 'Popular',
            ),
            ListImageHome(
              heroTagPrefix: 'Popular',
              padding: EdgeInsets.only(left: paddingInHome),
              listImagePath: MockData.listImage,
            ),
            _CategoryTitle(
              title: 'Actions',
            ),
            ListImageHome(
              heroTagPrefix: 'Actions',
              padding: EdgeInsets.only(left: paddingInHome),
              listImagePath: MockData.listImage,
            ),
            _CategoryTitle(
              title: 'Drama',
            ),
            ListImageHome(
              heroTagPrefix: 'Drama',
              padding: EdgeInsets.only(left: paddingInHome),
              listImagePath: MockData.listImage,
            )
          ],
        ),
      ),
    );
  }
}

class _CategoryTitle extends StatelessWidget {
  final String title;

  const _CategoryTitle({@required this.title});

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(left: $Home.paddingInHome, top: 17, bottom: 7),
        child: Text(
          this.title,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      );
}

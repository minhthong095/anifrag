import 'package:Anifrag/bloc/bloc_carousel.dart';
import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/config/path_image.dart';
import 'package:Anifrag/widget/hero_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 40),
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
        Flexible(
          flex: 5,
          child: TheCarousel(),
        ),
        Flexible(
          flex: 3,
          child: Center(
            child: InkWell(
              onTap: () {
                // Navigator.of(context).pushAndRemoveUntil(
                //     CupertinoPageRoute(builder: (context) => Detail()),
                //     (Route<dynamic> route) => false);
              },
              child: HeroImage(
                tag: "DURTY BIT",
                path: PathImage.casablanca,
                height: 150,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

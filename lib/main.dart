import 'package:Anifrag/bloc/bloc_carousel.dart';
import 'package:Anifrag/config/path.dart';
import 'package:Anifrag/screen/test_carousell.dart';
import 'package:Anifrag/widget/hero_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screen/detail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(backgroundColor: Colors.white, body: Home()),
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
  BlocCarousel _blocCarousel;

  @override
  void initState() {
    _blocCarousel = Provider.of<BlocCarousel>(context, listen: false);
    super.initState();
  }

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
              Text(
                "Most search",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5, bottom: 7),
                child: Text(
                  "Trending movies today",
                  style: TextStyle(fontSize: 17),
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
                Navigator.of(context).pushAndRemoveUntil(
                    CupertinoPageRoute(builder: (context) => Detail()),
                    (Route<dynamic> route) => false);
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

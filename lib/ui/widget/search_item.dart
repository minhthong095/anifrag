import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/config/path.dart';
import 'package:Anifrag/config/utils.dart';
import 'package:Anifrag/store/live_store.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'default_image_shimmer.dart';

class SearchItemScreenTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Container(
        color: AppColor.backgroundColor,
        child: Center(
            // child: SearchItem(
            //   runtime: 120,
            //   yearRelease: 2019,
            // ),
            ),
      ),
    );
  }
}

class SearchItem extends StatelessWidget {
  final String title;
  final DateTime yearRelease;
  final int runtime;
  final String popularity;
  final String posterPath;
  final double heightImg;
  final double widthImg;

  static const double _padding = 12;

  SearchItem(
      {@required this.title,
      @required this.popularity,
      @required this.runtime,
      @required this.posterPath,
      @required this.heightImg,
      @required this.widthImg,
      @required this.yearRelease});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(height: this.heightImg + _padding * 2),
      padding: EdgeInsets.all(_padding),
      decoration: BoxDecoration(
          color: Color(0xff26262c),
          borderRadius: BorderRadius.all(Radius.circular(9))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 15),
              child: FadeInImage(
                image: NetworkImage(posterPath),
                placeholder: AssetImage(PathImage.placeHolder),
              )),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                '${this.yearRelease == null ? '' : yearRelease.year.toString()}${this.yearRelease == null || this.runtime == 0 ? '' : ' * '}' +
                    Utils.generateStringRuntime(runtime),
                style: TextStyle(color: Colors.grey),
              ),
              Expanded(
                  child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  popularity + ' point',
                  style: TextStyle(color: Colors.grey),
                ),
              )),
            ],
          ))
        ],
      ),
    );
  }
}

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
  final int yearRelease;
  final int runtime;
  final String popularity;
  final String posterPath;

  static const double _preferHeight = 120;

  SearchItem(
      {@required String title,
      @required String popularity,
      @required int runtime,
      @required this.posterPath,
      @required int yearRelease})
      : this.title = title ?? '',
        this.yearRelease = yearRelease ?? null,
        this.runtime = runtime ?? null,
        this.popularity = popularity ?? '';

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(height: _preferHeight),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Color(0xff26262c),
          borderRadius: BorderRadius.all(Radius.circular(9))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: CachedNetworkImage(
              filterQuality: FilterQuality.low,
              imageUrl: posterPath,
              placeholder: (context, text) => DefaultImageShimmer(
                width: _preferHeight * LiveStore.ratioImgApi,
                height: _preferHeight,
              ),
            ),
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                '${this.yearRelease == null ? '' : this.yearRelease.toString()}${this.yearRelease == null || this.runtime == null ? '' : ' * '}' +
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

import 'dart:math';

import 'package:Anifrag/bloc/bloc_home.dart';
import 'package:Anifrag/config/mock_data.dart';
import 'package:Anifrag/config/path.dart';
import 'package:Anifrag/config/utils.dart';
import 'package:Anifrag/model/responses/response_home_page_movie.dart';
import 'package:Anifrag/store/live_store.dart';
import 'package:Anifrag/ui/screen/detail.dart';
import 'package:Anifrag/ui/screen/home.dart';
import 'package:Anifrag/ui/widget/hero_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListImageHome extends StatefulWidget {
  final List<ResponseThumbnailMovie> listHomePageMovie;
  final EdgeInsets padding;
  final String heroTagPrefix;
  final String baseUrlImg;
  final OnItemTap onItemTap;

  ListImageHome(
      {@required this.listHomePageMovie,
      @required this.onItemTap,
      @required this.padding,
      @required this.heroTagPrefix,
      @required this.baseUrlImg});

  @override
  _ListImageHomeState createState() => _ListImageHomeState();
}

class _ListImageHomeState extends State<ListImageHome> {
  static const double _preferHeightImg = 150;
  double _widthImg = 0;

  @override
  void didChangeDependencies() {
    _widthImg = _preferHeightImg * LiveStore.ratioImgApi;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(height: _preferHeightImg),
      child: ListView.builder(
        itemCount: this.widget.listHomePageMovie.length,
        scrollDirection: Axis.horizontal,
        padding: this.widget.padding,
        itemBuilder: (BuildContext context, int index) {
          final posterPath =
              widget.baseUrlImg + widget.listHomePageMovie[index].posterPath;
          return Padding(
            padding: EdgeInsets.only(right: 10),
            child: GestureDetector(
                onTap: () {
                  widget.onItemTap(
                      widget.listHomePageMovie[index].id, widget.heroTagPrefix);
                },
                child: HeroImage(
                  emptyMode: false,
                  width: _widthImg,
                  path: posterPath,
                  tag: widget.heroTagPrefix +
                      widget.listHomePageMovie[index].posterPath,
                )),
          );
        },
      ),
    );
  }
}

import 'dart:math';

import 'package:Anifrag/bloc/bloc_home.dart';
import 'package:Anifrag/config/mock_data.dart';
import 'package:Anifrag/config/path.dart';
import 'package:Anifrag/model/responses/response_home_page_movie.dart';
import 'package:Anifrag/ui/screen/detail.dart';
import 'package:Anifrag/ui/screen/home.dart';
import 'package:Anifrag/ui/widget/hero_image.dart';
import 'package:flutter/material.dart';

class ListImageHome extends StatelessWidget {
  final List<ResponseHomePageMovie> listHomePageMovie;
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
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(height: 150),
      child: ListView.builder(
        itemCount: this.listHomePageMovie.length,
        scrollDirection: Axis.horizontal,
        padding: this.padding,
        itemBuilder: (BuildContext context, int index) {
          final posterPath = baseUrlImg + listHomePageMovie[index].posterPath;
          return Padding(
            padding: EdgeInsets.only(right: 10),
            child: GestureDetector(
                onTap: () {
                  onItemTap(listHomePageMovie[index].id, heroTagPrefix);
                },
                child: HeroImage(
                  emptyMode: false,
                  path: posterPath,
                  tag: heroTagPrefix + listHomePageMovie[index].posterPath,
                )),
          );
        },
      ),
    );
  }
}

import 'dart:math';

import 'package:Anifrag/config/mock_data.dart';
import 'package:Anifrag/config/path.dart';
import 'package:Anifrag/screen/detail.dart';
import 'package:Anifrag/transition/detail_transition.dart';
import 'package:Anifrag/widget/hero_image.dart';
import 'package:flutter/material.dart';

class ListImageHome extends StatelessWidget {
  final List<String> listImagePath;
  final EdgeInsets padding;
  final String heroTagPrefix;

  ListImageHome(
      {@required this.listImagePath,
      @required this.padding,
      @required this.heroTagPrefix});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(height: 150),
      child: ListView.builder(
        itemCount: this.listImagePath.length,
        scrollDirection: Axis.horizontal,
        padding: this.padding,
        itemBuilder: (BuildContext context, int index) => Padding(
          padding: EdgeInsets.only(right: 10),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(Detail.nameRoute,
                  arguments: DetailArguments(
                      tagPrefix: heroTagPrefix,
                      imagePath: listImagePath[index]));
            },
            child: HeroImage(
              path: listImagePath[index],
              tag: heroTagPrefix + listImagePath[index],
            ),
          ),
        ),
      ),
    );
  }
}

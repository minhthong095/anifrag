import 'package:Anifrag/config/mock_data.dart';
import 'package:Anifrag/config/path_image.dart';
import 'package:Anifrag/widget/hero_image.dart';
import 'package:flutter/material.dart';

class ListImageHome extends StatelessWidget {
  final List<String> listImagePath;
  final EdgeInsets padding;
  ListImageHome({@required this.listImagePath, @required this.padding});

  @override
  Widget build(BuildContext context) => Container(
        constraints: BoxConstraints.expand(height: 150),
        child: ListView.builder(
          itemCount: this.listImagePath.length,
          scrollDirection: Axis.horizontal,
          padding: this.padding,
          itemBuilder: (BuildContext context, int index) => Padding(
            padding: EdgeInsets.only(right: 10),
            child: HeroImage(
              path: listImagePath[index],
              tag: "",
            ),
          ),
        ),
      );
}

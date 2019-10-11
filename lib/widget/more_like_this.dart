import 'package:Anifrag/config/mock_data.dart';
import 'package:flutter/material.dart';

import 'hero_image.dart';

class MoreLikeThis extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GridView.count(
        shrinkWrap: true,
        crossAxisCount: 3,
        childAspectRatio: 324 / 480,
        crossAxisSpacing: 20,
        padding: EdgeInsets.zero,
        physics: ClampingScrollPhysics(),
        mainAxisSpacing: 10,
        children: List.generate(MockData.listImage.length, (index) {
          return HeroImage(
            normalMode: 1,
            path: MockData.listImage[index],
            tag: MockData.listImage[index],
          );
        }),
      );
}

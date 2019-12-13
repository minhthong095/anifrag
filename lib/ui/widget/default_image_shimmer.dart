import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'empty_image.dart';

class DefaultImageShimmer extends StatelessWidget {
  final double width;
  final double height;

  DefaultImageShimmer({this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return EmptyImage(
      width: width,
      height: height,
    );

    // return Shimmer.fromColors(
    //     period: Duration(seconds: 4),
    //     baseColor: Color(0xff292831),
    //     highlightColor: Color(0xff393747),
    //     child: EmptyImage(
    //       width: width,
    //       height: height,
    //     ));
  }
}

import 'package:flutter/cupertino.dart';

class HeroImage extends StatelessWidget {
  final String path;
  final double height;
  final BoxFit fit;
  final String tag;
  final FilterQuality filterQuality;
  final int normalMode;
  const HeroImage(
      {@required this.tag,
      @required this.path,
      this.normalMode = 0,
      this.height,
      this.fit,
      this.filterQuality = FilterQuality.none});

  // @override
  // Widget build(BuildContext context) => Hero(
  //       tag: tag,
  //       child: ClipRRect(
  //         borderRadius: BorderRadius.circular(7.0),
  //         child: Image.asset(
  //           path,
  //           height: height,
  //           fit: fit,
  //           filterQuality: filterQuality,
  //         ),
  //       ),
  //     );

  @override
  Widget build(BuildContext context) {
    if (normalMode == 0) {
      return Hero(
        tag: tag,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(7.0),
          child: Image.asset(
            path,
            height: height,
            fit: fit,
            filterQuality: filterQuality,
          ),
        ),
      );
    } else
      return ClipRRect(
        borderRadius: BorderRadius.circular(7.0),
        child: Image.asset(
          path,
          height: height,
          fit: fit,
          filterQuality: filterQuality,
        ),
      );
  }
}

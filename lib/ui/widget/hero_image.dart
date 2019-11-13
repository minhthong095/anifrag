import 'package:Anifrag/ui/widget/empty_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeroImage extends StatelessWidget {
  final String path;
  final double height;
  final BoxFit fit;
  final String tag;
  final FilterQuality filterQuality;
  final bool normalMode;
  const HeroImage(
      {@required this.tag,
      @required this.path,
      this.normalMode = true,
      this.height,
      this.fit,
      this.filterQuality = FilterQuality.none});

  @override
  Widget build(BuildContext context) {
    if (normalMode) {
      return Hero(
        tag: tag,
        child: _borderImage(),
      );
    } else
      return _borderImage();
    // return ClipRRect(
    //   borderRadius: BorderRadius.circular(7.0),
    //   child: EmptyImage(),
    // );
    // return EmptyImage();
  }

  Widget _borderImage() => ClipRRect(
        borderRadius: BorderRadius.circular(7.0),
        child: Image.asset(
          path,
          height: height,
          fit: fit,
          filterQuality: filterQuality,
        ),
      );
}

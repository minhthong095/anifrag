import 'package:flutter/cupertino.dart';

class HeroImage extends StatelessWidget {
  final String path;
  final double height;
  final BoxFit fit;
  final String tag;
  final FilterQuality filterQuality;
  const HeroImage(
      {@required this.tag,
      @required this.path,
      this.height,
      this.fit,
      this.filterQuality = FilterQuality.none});

  @override
  Widget build(BuildContext context) => Hero(
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
}

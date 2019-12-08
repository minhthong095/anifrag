import 'package:Anifrag/ui/widget/empty_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HeroImage extends StatelessWidget {
  final String path;
  final double height;
  final BoxFit fit;
  final String tag;
  final FilterQuality filterQuality;
  final bool emptyMode;
  const HeroImage(
      {@required this.tag,
      @required this.path,
      this.emptyMode = true,
      this.height,
      this.fit,
      this.filterQuality = FilterQuality.none});

  @override
  Widget build(BuildContext context) {
    if (!emptyMode) {
      return Hero(
        tag: tag,
        child: _borderImage(),
      );
    } else
      // return _borderImage();
      return ClipRRect(
        borderRadius: BorderRadius.circular(7.0),
        child: EmptyImage(
          height: this.height,
        ),
      );
    // return EmptyImage();
  }

  Widget _borderImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(7.0),
      // child: Image.asset(
      //   path,
      //   height: height,
      //   fit: fit,
      //   filterQuality: filterQuality,
      // ),
      child: CachedNetworkImage(
        imageUrl: path,
        height: height,
        fit: fit,
        filterQuality: filterQuality,
        placeholder: (context, text) => Shimmer.fromColors(
            period: Duration(seconds: 4),
            baseColor: Color(0xff292831),
            highlightColor: Color(0xff393747),
            child: EmptyImage(
              height: this.height,
            )),
      ),
    );
  }
}

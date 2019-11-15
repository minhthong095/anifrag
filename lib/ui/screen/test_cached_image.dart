import 'package:Anifrag/config/app_color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TestCachedImage extends StatelessWidget {
  Future<String> getImage() async {
    await Future.delayed(Duration(seconds: 3));
    return 'https://image.tmdb.org/t/p/w500/kqjL17yufvn9OVLyXYpvtyrFfak.jpg';
  }

  @override
  Widget build(BuildContext context) => Container(
        child: Center(
          child: SizedBox(
            height: 300,
            width: 500,
            child: Container(
              color: AppColor.backgroundColor,
              child: Center(
                child: CachedNetworkImage(
                  imageUrl: "",
                  placeholder: (context, text) => Shimmer.fromColors(
                      period: Duration(seconds: 4),
                      baseColor: Color(0xff292831),
                      highlightColor: Color(0xff393747),
                      child: Container(
                        color: Colors.yellow,
                      )),
                  // placeholder: (context, text) => Container(
                  //   decoration: BoxDecoration(
                  //       gradient: LinearGradient(
                  //           begin: Alignment.topLeft,
                  //           end: Alignment.centerRight,
                  //           colors: [
                  //         Color(0xff3F3E47),
                  //         Color(0xff292831),
                  //       ],
                  //           stops: [
                  //         0.0,
                  //         1.0
                  //       ])),
                  // ),
                  // placeholder: (context, text) => Shimmer(
                  //   period: Duration(seconds: 5),
                  //   gradient: LinearGradient(
                  //       begin: Alignment.topLeft,
                  //       end: Alignment.centerRight,
                  //       colors: [
                  //         Color(0xff292831),
                  //         Color(0xff292831),
                  //         Color(0xff393747),
                  //         Color(0xff292831),
                  //         Color(0xff292831),
                  //       ],
                  //       stops: [
                  //         0.0,
                  //         0.35,
                  //         0.5,
                  //         0.65,
                  //         1.0
                  //       ]),
                  //   child: Container(
                  //     color: Colors.yellow,
                  //   ),
                  // ),
                  // imageUrl: await getImage()
                ),
              ),
            ),
          ),
        ),
      );
}

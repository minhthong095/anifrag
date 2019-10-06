import 'package:Anifrag/config/path.dart';
import 'package:Anifrag/widget/hero_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Detail extends StatelessWidget {
  static final double _paddingTopImage = 20;
  final double _mergeGap = 30;
  final double _heightImageFrame = 320 + _paddingTopImage;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            // Positioned(
            //   top: 0,
            //   left: 0,
            //   right: 0,
            //   height: _heightImageFrame,
            //   child: Container(
            //     color: Colors.red,
            //   ),
            // ),
            Positioned(
              top: _heightImageFrame - _mergeGap,
              left: 0,
              right: 0,
              bottom: 0,
              child: SafeArea(
                top: false,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20))),
                ),
              ),
            ),
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: _heightImageFrame,
                child: SafeArea(
                  bottom: false,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: _paddingTopImage),
                          child: HeroImage(
                            tag: "DURTY BIT",
                            path: PathImage.casablanca,
                            height: _heightImageFrame,
                            fit: BoxFit.fill,
                          ),
                        )
                      ],
                    ),
                  ),
                ))
          ],
        ),
      );
}

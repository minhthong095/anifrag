import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/config/path.dart';
import 'package:Anifrag/widget/detail_tab.dart';

import 'package:Anifrag/widget/comment.dart';
import 'package:Anifrag/widget/hero_image.dart';
import 'package:Anifrag/widget/text_percent.dart';
import 'package:Anifrag/widget/text_star.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Detail extends StatelessWidget {
  static final double _paddingTopImage = 20;
  final double _mergeGap = 30;
  final double _heightImageFrame = 320 + _paddingTopImage;
  static final double paddingContent = 17;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: Stack(
          children: <Widget>[
            Positioned(
              top: _heightImageFrame - _mergeGap,
              left: 0,
              right: 0,
              bottom: 0,
              child: SafeArea(
                top: false,
                child: Container(
                  child: _Content(),
                  decoration: BoxDecoration(
                      color: Colors.white,
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

class _Content extends StatelessWidget {
  // @override
  // Widget build(BuildContext context) => Padding(
  //       padding: EdgeInsets.only(top: 52),
  //       child: CustomScrollView(
  //         slivers: <Widget>[
  //           SliverList(
  //             delegate: SliverChildListDelegate([
  //               Column(
  //                 children: <Widget>[
  //                   Text(
  //                     'Casablanca',
  //                     style:
  //                         TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
  //                   ),
  //                   SizedBox.fromSize(
  //                     size: Size(0, 7),
  //                   ),
  //                   Text(
  //                     '1942 * 1h 42min',
  //                     style: TextStyle(color: Colors.grey),
  //                   )
  //                 ],
  //               ),
  //               SizedBox.fromSize(
  //                 size: Size(0, 30),
  //               ),
  //               Row(
  //                 children: <Widget>[
  //                   Flexible(
  //                     child: Comment(
  //                       top: TextStar(
  //                         fontSize: 25,
  //                         value: 8.3,
  //                       ),
  //                       comment: '77 857',
  //                     ),
  //                   ),
  //                   Flexible(
  //                     child: Comment(
  //                       top: TextPercent(
  //                         iconPath: PathIcon.smallChart,
  //                         fontSize: 25,
  //                         value: 78,
  //                       ),
  //                       comment: 'In your taste',
  //                     ),
  //                   ),
  //                   Flexible(
  //                     child: Comment(
  //                       top: TextPercent(
  //                         iconPath: PathIcon.fresh,
  //                         fontSize: 25,
  //                         value: 98,
  //                       ),
  //                       comment: 'Fresh',
  //                     ),
  //                   )
  //                 ],
  //               ),
  //               SizedBox.fromSize(
  //                 size: Size(0, 30),
  //               ),
  //               Padding(
  //                 padding:
  //                     EdgeInsets.symmetric(horizontal: Detail.paddingContent),
  //                 child: DetailTab(),
  //               )
  //             ]),
  //           )
  //         ],
  //       ),
  //     );

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(
          top: 52,
        ),
        child: Column(
          children: <Widget>[
            Text(
              'Casablanca',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox.fromSize(
              size: Size(0, 7),
            ),
            Text(
              '1942 * 1h 42min',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox.fromSize(
              size: Size(0, 30),
            ),
            Row(
              children: <Widget>[
                Flexible(
                  child: Comment(
                    top: TextStar(
                      fontSize: 25,
                      value: 9,
                    ),
                    comment: '77 857',
                  ),
                ),
                Flexible(
                  child: Comment(
                    top: TextPercent(
                      iconPath: PathIcon.smallChart,
                      fontSize: 25,
                      value: 9,
                    ),
                    comment: 'In your taste',
                  ),
                ),
                Flexible(
                  child: Comment(
                    top: TextPercent(
                      iconPath: PathIcon.fresh,
                      fontSize: 25,
                      value: 98,
                    ),
                    comment: 'Fresh',
                  ),
                )
              ],
            ),
            SizedBox.fromSize(
              size: Size(0, 30),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Detail.paddingContent),
              child: DetailTab(),
            )
          ],
        ),
      );
}

import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/model/responses/response_movie.dart';
import 'package:Anifrag/ui/widget/skuru_panel.dart';
import 'package:Anifrag/ui/widget/text_more.dart';
import 'package:flutter/material.dart';

class ContentSearchDetail extends StatelessWidget {
  final ResponseMovie responseMovie;

  static const _paddingContent = EdgeInsets.all(23);

  ContentSearchDetail({@required this.responseMovie});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SkuruPanel(
          backgroundColor: AppColor.backgroundColor,
          titleColor: Colors.white,
          height: 80,
          percentPoint: responseMovie?.voteAverage,
          paddingLeftTitle: _paddingContent.left,
          title: responseMovie?.title,
        ),
        Container(
          color: AppColor.backgroundColor,
          padding: EdgeInsets.only(
              left: _paddingContent.left,
              right: _paddingContent.right,
              top: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  'Synopsis',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              TextMoreOneWay(
                  tapReadMore: () {},
                  readMoreText: '   Read more',
                  text: responseMovie?.overview),
              // CastsRow(),
              SizedBox(
                height: 100,
                width: double.infinity,
              )
            ],
          ),
        )
      ],
    );
  }
}

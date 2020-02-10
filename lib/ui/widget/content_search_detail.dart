import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/ui/widget/skuru_panel.dart';
import 'package:Anifrag/ui/widget/text_more.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ContentSearchDetail extends StatelessWidget {
  static const _paddingContent = EdgeInsets.all(23);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SkuruPanel(
          backgroundColor: AppColor.backgroundColor,
          titleColor: Colors.white,
          height: 80,
          paddingLeftTitle: _paddingContent.left,
          title: 'Breaking Bad',
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
                text:
                    '''Walter H. White is a chemistry genius, but works as a chemistry teacher in an Albequerque, New Mexico high school. w Mexico high school. Walter H. White is a chemistry genius, but works as a chemistry teacher in an Albequerque, New Mexico high school. w Mexico high school. Walter H. White is a chemistry genius, but works as a chemistry teacher in an Albequerque, New Mexico high school. w Mexico high school.''',
              ),
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

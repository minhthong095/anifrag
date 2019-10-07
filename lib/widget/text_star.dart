import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/config/path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextStar extends StatelessWidget {
  final num value;
  final double fontSize;

  const TextStar({@required this.value, @required this.fontSize});

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            PathIcon.star,
            filterQuality: FilterQuality.none,
            fit: BoxFit.fill,
            height: this.fontSize - 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 4),
            child: Text(
              value.toString(),
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColor.yellow,
                fontSize: this.fontSize,
              ),
            ),
          )
        ],
      );
}

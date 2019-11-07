import 'package:Anifrag/config/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TextPercent extends StatelessWidget {
  final num value;
  final String iconPath;
  final double fontSize;

  const TextPercent(
      {@required this.value, @required this.fontSize, @required this.iconPath});

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            iconPath,
            filterQuality: FilterQuality.none,
            fit: BoxFit.fill,
            height: this.fontSize - 5,
          ),
          Padding(
            padding: EdgeInsets.only(left: 3),
            child: RichText(
              text: TextSpan(
                  text: value.toString(),
                  style: TextStyle(
                    color: Colors.grey,
                    // backgroundColor: Colors.yellow,
                    fontSize: this.fontSize,
                  ),
                  children: <InlineSpan>[
                    WidgetSpan(
                        child: Padding(
                      padding: EdgeInsets.only(left: 3, bottom: 2),
                      child: Text('%',
                          style: TextStyle(
                            color: Colors.grey,
                            // backgroundColor: Colors.yellow,
                            fontSize: this.fontSize - 7,
                          )),
                    ))
                  ]),
            ),
          ),
        ],
      );
}

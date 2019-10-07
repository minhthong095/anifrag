import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Comment extends StatelessWidget {
  final Widget top;
  final String comment;
  const Comment({@required this.top, @required this.comment});

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              this.top,
              SizedBox.fromSize(
                size: Size(0, 2),
              ),
              Text(
                this.comment,
                style: TextStyle(color: Colors.grey),
              )
            ],
          )
        ],
      );
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Comment extends StatelessWidget {
  final Widget top;
  final String comment;
  const Comment({@required this.top, @required this.comment});

  @override
  Widget build(BuildContext context) =>
      // Container(
      //     decoration: BoxDecoration(
      //       color: Colors.red,
      //       border: Border.all(width: 2),
      //     ),
      //     child:
      Column(
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
  // );
}

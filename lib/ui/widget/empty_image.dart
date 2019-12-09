import 'package:Anifrag/store/live_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyImage extends StatelessWidget {
  final double height;
  final double width;

  EmptyImage({@required this.height, @required this.width});

  @override
  Widget build(BuildContext context) => Container(
        constraints: BoxConstraints.expand(
            height: height,
            // width: (this.height * LiveStore.tempHardCodeAspectRatio)
            width: width),
        color: Color(0xff2a2b2f),
      );
}

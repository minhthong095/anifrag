import 'package:Anifrag/store/live_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyImage extends StatelessWidget {
  double height;

  EmptyImage({this.height}) {
    this.height ??= 0;
  }

  @override
  Widget build(BuildContext context) => Container(
        constraints: BoxConstraints.expand(
            height: this.height,
            width: (this.height * LiveStore.tempHardCodeAspectRatio)),
        color: Color(0xff2a2b2f),
      );
}

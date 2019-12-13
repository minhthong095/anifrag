import 'package:Anifrag/store/live_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyImage extends StatelessWidget {
  final double height;
  final double width;

  EmptyImage({@required this.height, @required this.width});

  @override
  Widget build(BuildContext context) => Container(
        constraints: BoxConstraints.tight(Size(width, height)),
        color: Color(0xff404145),
      );
}

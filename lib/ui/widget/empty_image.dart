import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        constraints: BoxConstraints.tight(Size(110, 110)),
        color: Color(0xff2a2b2f),
      );
}
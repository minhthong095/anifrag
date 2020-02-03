import 'package:Anifrag/ui/widget/skuru_panel.dart';
import 'package:flutter/material.dart';

class ContentSearchDetail extends StatelessWidget {
  static const _paddingContent = EdgeInsets.all(30);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SkuruPanel(
          height: 50,
          paddingLeftTitle: _paddingContent.left,
          title: 'Breaking Bad',
        ),
        Container(
          color: Colors.red,
          height: 100,
        )
      ],
    );
  }
}

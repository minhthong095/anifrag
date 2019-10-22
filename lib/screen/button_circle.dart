import 'package:Anifrag/config/app_color.dart';
import 'package:flutter/material.dart';

class ButtonCircle extends StatelessWidget {
  final VoidCallback onTap;
  final String iconPath;

  const ButtonCircle({@required this.onTap, @required this.iconPath});

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () {
          onTap();
        },
        child: Center(
            child: Container(
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Image.asset(
                iconPath,
                filterQuality: FilterQuality.none,
              )),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(Colors.white.value).withOpacity(0.2)),
          constraints: BoxConstraints.tight(Size(50, 50)),
        )),
      );
}

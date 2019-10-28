import 'package:Anifrag/config/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TestSvg extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        child: Center(
          child: Container(
            height: 100,
            width: 100,
            child: SvgPicture.asset(
              PathSvg.find,
              color: Colors.red,
            ),
          ),
        ),
      );
}

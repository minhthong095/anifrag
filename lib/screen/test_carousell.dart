import 'package:Anifrag/config/path.dart';
import 'package:Anifrag/widget/hero_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TheCarousel extends StatefulWidget {
  @override
  _TheCarousel createState() => _TheCarousel();
}

class _TheCarousel extends State<TheCarousel> {
  PageController _pageController = PageController(viewportFraction: 0.8);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      physics: ClampingScrollPhysics(),
      controller: _pageController,
      itemCount: 6,
      itemBuilder: (context, index) {
        return AnimatedBuilder(
          animation: _pageController,
          builder: (context, widget) {
            if (_pageController.position.haveDimensions) {
              // First time pageController still not init yet, need some hack
              return _Item(
                scale: ((_pageController.page - index).abs() * (0.9 - 1)) + 1,
              );
            }
            return _Item(
              scale: (index * (0.9 - 1)) + 1,
            );
          },
        );
      },
    );
  }
}

class _Item extends StatelessWidget {
  final double scale;

  const _Item({@required this.scale});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: Colors.red, border: Border.all(width: 1)),
      child: Transform.scale(
        scale: scale,
        child: HeroImage(
          fit: BoxFit.fitWidth,
          path: PathImage.casablanca,
          tag: 'tag',
        ),
      ),
    );
  }
}

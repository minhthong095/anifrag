import 'package:Anifrag/config/mock_data.dart';
import 'package:Anifrag/config/path.dart';
import 'package:Anifrag/transition/detail_transition.dart';
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
    return ConstrainedBox(
      constraints: BoxConstraints.expand(height: 370),
      child: PageView.builder(
        onPageChanged: (index) {},
        physics: ClampingScrollPhysics(),
        controller: _pageController,
        itemCount: MockData.listImage.length,
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: _pageController,
            builder: (context, widget) {
              try {
                return _Item(
                  imagePath: MockData.listImage[index],
                  scale: ((_pageController.page - index).abs() * (0.9 - 1)) + 1,
                );
              } catch (e) {
                // First time pageController still not init yet, need some hack
                // _pageController.page equal 0
                return _Item(
                  imagePath: MockData.listImage[index],
                  scale: (index * (0.9 - 1)) + 1,
                );
              }
            },
          );
        },
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final double scale;
  final String imagePath;
  const _Item({@required this.scale, @required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(DetailTransition(imagePath: imagePath));
        },
        child: HeroImage(
          path: imagePath,
          fit: BoxFit.fitWidth,
          tag: "AtoB" + imagePath,
        ),
      ),
    );
  }
}

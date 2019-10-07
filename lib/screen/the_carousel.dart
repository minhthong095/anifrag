import 'package:Anifrag/config/mock_data.dart';
import 'package:Anifrag/config/path_image.dart';
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
      constraints: BoxConstraints.expand(height: 400),
      child: PageView.builder(
        physics: ClampingScrollPhysics(),
        controller: _pageController,
        itemCount: MockData.listImage.length,
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: _pageController,
            builder: (context, widget) {
              if (_pageController.position.haveDimensions) {
                // First time pageController still not init yet, need some hack
                return _Item(
                  imagePath: MockData.listImage[index],
                  scale: ((_pageController.page - index).abs() * (0.9 - 1)) + 1,
                );
              }
              return _Item(
                imagePath: MockData.listImage[index],
                scale: (index * (0.9 - 1)) + 1,
              );
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
      child: HeroImage(
        path: imagePath,
        fit: BoxFit.fitWidth,
        tag: 'tag',
      ),
      // child: ConstrainedBox(
      //   constraints: BoxConstraints.expand(),
      //   child: Stack(
      //     fit: StackFit.passthrough,
      //     children: <Widget>[
      //       HeroImage(
      //         fit: BoxFit.fitWidth,
      //         path: imagePath,
      //         tag: 'tag',
      //       ),
      //       Container(
      //         decoration: BoxDecoration(
      //             borderRadius: BorderRadius.all(Radius.circular(7.0)),
      //             gradient: LinearGradient(
      //                 stops: [0.01, 1],
      //                 begin: Alignment.bottomCenter,
      //                 end: Alignment.topCenter,
      //                 colors: [Colors.black87, Colors.transparent])),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}

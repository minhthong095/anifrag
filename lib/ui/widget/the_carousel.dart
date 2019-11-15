import 'dart:math';

import 'package:Anifrag/bloc/bloc_home.dart';
import 'package:Anifrag/config/mock_data.dart';
import 'package:Anifrag/config/path.dart';
import 'package:Anifrag/ui/screen/detail.dart';
import 'package:Anifrag/ui/screen/main_tab.dart';
import 'package:Anifrag/ui/widget/hero_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'loading_route.dart';

class TheCarousel extends StatefulWidget {
  @override
  _TheCarousel createState() => _TheCarousel();
}

class _TheCarousel extends State<TheCarousel> {
  PageController _pageController = PageController(viewportFraction: 0.8);

  BlocHome _blocHome;

  @override
  void didChangeDependencies() {
    _blocHome = Provider.of<BlocHome>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(height: 500),
      child: PageView.builder(
        onPageChanged: (index) {},
        physics: ClampingScrollPhysics(),
        controller: _pageController,
        itemCount: _blocHome.listCarousel().length,
        itemBuilder: (context, index) {
          final posterPath = _blocHome.baseUrlImage() +
              _blocHome.listCarousel().elementAt(index).posterPath;
          return AnimatedBuilder(
            animation: _pageController,
            builder: (context, widget) {
              try {
                return _Item(
                  imagePath: posterPath,
                  scale: ((_pageController.page - index).abs() * (0.9 - 1)) + 1,
                );
              } catch (e) {
                // First time pageController still not init yet, need some hack
                // _pageController.page equal 0
                return _Item(
                  imagePath: posterPath,
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
        onTap: () async {
          // Navigator.of(context).push(DetailTransition(
          //     child: Detail(
          //   arguments: DetailArguments(imagePath: imagePath, tagPrefix: 'AtoB'),
          // )));
          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Mod));
          // Navigator.pop(context)
          // Navigator.of(context).pushNamed(Detail.nameRoute,
          //     arguments:
          //         DetailArguments(imagePath: imagePath, tagPrefix: 'AtoB'));
          Navigator.of(context).popUntil(LoadingRoute.loadingRoutePredicate());
        },
        child: HeroImage(
          emptyMode: false,
          filterQuality: FilterQuality.low,
          path: imagePath,
          fit: BoxFit.fitWidth,
          tag: "AtoB" + imagePath,
        ),
      ),
    );
  }
}

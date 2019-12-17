import 'dart:math';

import 'package:Anifrag/bloc/bloc_home.dart';
import 'package:Anifrag/config/mock_data.dart';
import 'package:Anifrag/config/path.dart';
import 'package:Anifrag/config/utils.dart';
import 'package:Anifrag/model/responses/response_home_page_movie.dart';
import 'package:Anifrag/store/live_store.dart';
import 'package:Anifrag/ui/screen/detail.dart';
import 'package:Anifrag/ui/screen/home.dart';
import 'package:Anifrag/ui/screen/main_tab_bar.dart';
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
  // PageController _pageController = PageController(viewportFraction: 0.7);
  PageController _pageController;
  double _heightImage;
  BlocHome _blocHome;

  @override
  void didChangeDependencies() {
    _blocHome = Provider.of<BlocHome>(context, listen: false);

    // Calculate carousel image base on data image from API
    final rawWidthImgDp = Utils.getWidthDpImgApi(context); // w300
    final ratioPreferWidthScreenSize = 0.7;
    final ratioRawWidthImgOnScreenSize =
        rawWidthImgDp / MediaQuery.of(context).size.width;
    final widthImgDpOnPreferRatio = ratioPreferWidthScreenSize *
        rawWidthImgDp /
        ratioRawWidthImgOnScreenSize;
    final heightImgDbOnPreferRatio =
        widthImgDpOnPreferRatio / LiveStore.ratioImgApi;

    _pageController =
        PageController(viewportFraction: ratioPreferWidthScreenSize);
    _heightImage = heightImgDbOnPreferRatio;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(height: _heightImage),
      child: PageView.builder(
        onPageChanged: (index) {},
        physics: ClampingScrollPhysics(),
        controller: _pageController,
        itemCount: _blocHome.listCarousel().length,
        itemBuilder: (context, index) {
          final movie = _blocHome.listCarousel().elementAt(index);
          //     final movie = _blocHome.baseUrlImage() +
          // _blocHome.listCarousel().elementAt(index).posterPath;
          return AnimatedBuilder(
            animation: _pageController,
            builder: (context, widget) {
              try {
                return _Item(
                  movie: movie,
                  scale: ((_pageController.page - index).abs() * (0.9 - 1)) + 1,
                );
              } catch (e) {
                // First time pageController still not init yet, need some hack
                // _pageController.page equal 0
                return _Item(
                  movie: movie,
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

class _Item extends StatefulWidget {
  final double scale;
  final ResponseThumbnailMovie movie;
  const _Item({@required this.scale, @required this.movie});

  @override
  __ItemState createState() => __ItemState();
}

class __ItemState extends State<_Item> {
  BlocHome _blocHome;
  OnItemTap _onItemTap;

  @override
  void didChangeDependencies() {
    _blocHome = Provider.of<BlocHome>(context, listen: false);
    _onItemTap = Provider.of<OnItemTap>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: widget.scale,
      child: GestureDetector(
          onTap: () {
            _onItemTap(widget.movie.id, 'Carousel');
          },
          child: HeroImage(
            emptyMode: false,
            filterQuality: FilterQuality.low,
            path: _blocHome.getBaseUrlImage + widget.movie.posterPath,
            tag: "Carousel" + widget.movie.posterPath,
          )),
    );
  }
}

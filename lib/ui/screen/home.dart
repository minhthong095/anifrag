import 'dart:io';

import 'package:Anifrag/bloc/bloc_home.dart';
import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/config/mock_data.dart';
import 'package:Anifrag/model/responses/response_home_page_movie.dart';
import 'package:Anifrag/ui/widget/loading_route.dart';
import 'package:Anifrag/ui/widget/the_carousel.dart';
import 'package:Anifrag/ui/widget/list_image_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'detail.dart';

class Home extends StatefulWidget {
  @override
  $Home createState() => $Home();
}

typedef OnItemTap = void Function(int idMovie, String prefix);

class $Home extends State<Home> {
  static final double paddingInHome = 20;

  BlocHome _blocHome;
  OnItemTap _onItemTap;
  Map<String, List<ResponseHomePageMovie>> _rest;

  @override
  void didChangeDependencies() {
    _blocHome = Provider.of<BlocHome>(context);
    _rest = _blocHome.listRestMovies();
    _onItemTap = (int idMovie, String prefix) {
      Navigator.of(context).pushNamed(LoadingRoute.nameRoute);
      _blocHome.getMovie(idMovie, (responseMovie, responseCast) {
        Navigator.of(context).popUntil(LoadingRoute.loadingRoutePredicate());
        Navigator.of(context).pushNamed(Detail.nameRoute,
            arguments: DetailArguments(prefix, responseMovie, responseCast));
      });
    };
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: Platform.isIOS
                        ? EdgeInsets.only(left: paddingInHome)
                        : EdgeInsets.only(left: paddingInHome, top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _blocHome.mainCategory(),
                          style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            "Trending movies today",
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Provider<OnItemTap>(
              builder: (context) => _onItemTap,
              child: TheCarousel(),
            ),
            for (String categoryTitle in _rest.keys)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _CategoryTitle(
                    title: categoryTitle,
                  ),
                  Provider<OnItemTap>(
                    builder: (context) => _onItemTap,
                    child: ListImageHome(
                      onItemTap: (int idMovie, String prefix) {
                        Navigator.of(context).pushNamed(LoadingRoute.nameRoute);
                        _blocHome.getMovie(idMovie,
                            (responseMovie, responseCast) {
                          Navigator.of(context)
                              .popUntil(LoadingRoute.loadingRoutePredicate());
                          Navigator.of(context).pushNamed(Detail.nameRoute,
                              arguments: DetailArguments(
                                  prefix, responseMovie, responseCast));
                        });
                      },
                      baseUrlImg: _blocHome.baseUrlImage(),
                      heroTagPrefix: categoryTitle,
                      padding: EdgeInsets.only(left: paddingInHome),
                      listHomePageMovie: _rest[categoryTitle],
                    ),
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _CategoryTitle extends StatelessWidget {
  final String title;

  const _CategoryTitle({@required this.title});

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(left: $Home.paddingInHome, top: 17, bottom: 7),
        child: Text(
          this.title,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      );
}

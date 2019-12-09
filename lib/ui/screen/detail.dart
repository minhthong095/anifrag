import 'package:Anifrag/bloc/bloc_detail.dart';
import 'package:Anifrag/bloc/bloc_home.dart';
import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/config/path.dart';
import 'package:Anifrag/di/component.dart';
import 'package:Anifrag/model/responses/response_cast.dart';
import 'package:Anifrag/model/responses/response_movie.dart';
import 'package:Anifrag/ui/widget/button_circle.dart';
import 'package:Anifrag/ui/widget/detail_tabbar.dart';

import 'package:Anifrag/ui/widget/comment.dart';
import 'package:Anifrag/ui/widget/hero_image.dart';
import 'package:Anifrag/ui/widget/loading_route.dart';
import 'package:Anifrag/ui/widget/text_percent.dart';
import 'package:Anifrag/ui/widget/text_star.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatelessWidget {
  final DetailScreenArgument argument;
  static const String nameRoute = '/detail';
  static const Duration durationTransition = const Duration(milliseconds: 350);

  DetailScreen({@required this.argument});

  @override
  Widget build(BuildContext context) {
    final blocDetail = ComponentInjector.I.blocDetail;
    blocDetail
      ..setMovie(argument.movie)
      ..setTagPrefix(argument.tagPrefix)
      ..setCasts(argument.casts);

    return MultiProvider(
      providers: [
        Provider<BlocHome>.value(value: ComponentInjector.I.blocHome),
        Provider<BlocDetail>(
          create: (ctx) => blocDetail,
          dispose: (_, bloc) {
            bloc.dispose();
          },
        )
      ],
      child: _DetailScreen(),
    );
  }
}

class _DetailScreen extends StatefulWidget {
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<_DetailScreen>
    with SingleTickerProviderStateMixin {
  static final double _paddingTopImage = 20;
  final double _mergeGap = 30;
  final double _heightImage = 320 + _paddingTopImage;
  double _defaultDiameterCircle = 0;
  static final double paddingContent = 17;
  Animation<Offset> _animationBotToTop;
  Animation<double> _animationCircle;
  Animation<double> _animationPaddingCircle;
  Animation<double> _animationOpacityCircle;
  AnimationController _controller;
  BlocDetail _bloc;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: DetailScreen.durationTransition);
    _animationBotToTop = Tween<Offset>(begin: Offset(0, 1), end: Offset.zero)
        .chain(CurveTween(curve: Curves.easeOutCubic))
        .animate(_controller);
    _animationCircle = Tween<double>(begin: 0, end: 2.5).animate(_controller);
    _animationPaddingCircle =
        Tween<double>(begin: 0, end: 15).animate(_controller);
    _animationOpacityCircle = Tween<double>(begin: 0, end: 1)
        .chain(CurveTween(curve: Curves.easeInQuint))
        .animate(_controller);
    _controller.addStatusListener(_controllerListener);
    _controller.forward();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    _getSizeOfCircle();
    _initBlocDetail();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.removeStatusListener(_controllerListener);
    super.dispose();
  }

  void _controllerListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _bloc.callFinishTransition();
    }
  }

  void _getSizeOfCircle() {
    final widthScreen = MediaQuery.of(context).size.width;
    if (widthScreen < 300) {
      _defaultDiameterCircle = widthScreen;
    } else {
      _defaultDiameterCircle = 300;
    }
  }

  void _initBlocDetail() {
    _bloc = Provider.of<BlocDetail>(context);
    _bloc.callMoreLikeThis();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox.fromSize(
                    size: Size(
                        double.infinity,
                        _heightImage +
                            _paddingTopImage +
                            MediaQuery.of(context).padding.top -
                            _mergeGap),
                    child: AnimatedBuilder(
                      animation: _animationCircle,
                      child: Container(
                        constraints: BoxConstraints.tightFor(
                            height: _defaultDiameterCircle),
                        decoration: BoxDecoration(
                            color: AppColor.yellow, shape: BoxShape.circle),
                      ),
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _animationCircle.value,
                          child: child,
                        );
                      },
                    ),
                  ),
                  SlideTransition(
                      position: _animationBotToTop,
                      child: _Content(
                        movie: _bloc.getMovie,
                      )),
                ],
              ),
              SafeArea(
                bottom: false,
                child: Padding(
                  padding: EdgeInsets.only(top: _paddingTopImage),
                  child: Container(
                    constraints: BoxConstraints.expand(height: _heightImage),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: AnimatedBuilder(
                              animation: _controller,
                              child: ButtonCircle(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                iconPath: PathIcon.back,
                              ),
                              builder: (BuildContext context, Widget child) =>
                                  Padding(
                                padding: EdgeInsets.only(
                                    left: _animationPaddingCircle.value,
                                    top: 20),
                                child: Opacity(
                                  opacity: _controller.value, // 0 to 1
                                  child: child,
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // _bloc.callMoreLikeThis();
                          },
                          child: HeroImage(
                            emptyMode: false,
                            tag: _bloc.getTagPrefix + _bloc.getMovie.posterPath,
                            path: _bloc.currentPosterPath,
                            height: _heightImage,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.topRight,
                            child: AnimatedBuilder(
                              animation: _controller,
                              child: ButtonCircle(
                                onTap: () {},
                                padding: 11,
                                iconPath: PathIcon.share,
                              ),
                              builder: (BuildContext context, Widget child) =>
                                  Padding(
                                padding: EdgeInsets.only(
                                    right: _animationPaddingCircle.value,
                                    top: 20),
                                child: Opacity(
                                  opacity:
                                      _animationOpacityCircle.value, // 0 to 1
                                  child: child,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
}

class _Content extends StatelessWidget {
  final ResponseMovie movie;
  const _Content({@required this.movie});

  String _getRunTime() => movie.runtime != null
      ? ' * ' +
          (movie.runtime / 60).toStringAsFixed(0) +
          'h ' +
          (movie.runtime % 60).toStringAsFixed(0) +
          'min'
      : '';

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
            color: AppColor.backgroundColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        child: Padding(
          padding: EdgeInsets.only(
            top: 52,
          ),
          child: Column(
            children: <Widget>[
              Text(
                movie.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox.fromSize(
                size: Size(0, 7),
              ),
              Text(
                movie.releaseDate.year.toString() + _getRunTime(),
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox.fromSize(
                size: Size(0, 30),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Comment(
                        top: TextStar(
                          fontSize: 25,
                          value:
                              double.parse(movie.popularity.toStringAsFixed(1)),
                        ),
                        comment: movie.voteCount.toStringAsFixed(0),
                      ),
                    ),
                    Flexible(
                      child: Comment(
                        top: TextPercent(
                            iconPath: PathIcon.smallChart,
                            fontSize: 25,
                            value: double.parse(
                                movie.voteAverage.toStringAsFixed(1))),
                        comment: 'In your taste',
                      ),
                    ),
                    Flexible(
                      child: Comment(
                        top: TextPercent(
                            iconPath: PathIcon.fresh,
                            fontSize: 25,
                            value: double.parse(
                                movie.popularity.toStringAsFixed(1))),
                        comment: 'Fresh',
                      ),
                    )
                  ],
                ),
              ),
              SizedBox.fromSize(
                size: Size(0, 30),
              ),
              SafeArea(
                top: false,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: _DetailScreenState.paddingContent),
                  child: DetailTabbar(),
                ),
              )
            ],
          ),
        ),
      );
}

class DetailScreenArgument {
  final String tagPrefix;
  final ResponseMovie movie;
  final List<ResponseCast> casts;
  const DetailScreenArgument(this.tagPrefix, this.movie, this.casts);
}

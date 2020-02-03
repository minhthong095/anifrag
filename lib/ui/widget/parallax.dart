import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/config/path.dart';
import 'package:Anifrag/config/utils.dart';
import 'package:Anifrag/model/responses/response_search.dart';
import 'package:Anifrag/store/live_store.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lottie/flutter_lottie.dart';

class Parallax extends StatefulWidget {
  final String originalTitle;
  final ImageProvider imageProvider;
  final Widget child;
  final double paddingBottomOriginal;

  Parallax(
      {this.originalTitle,
      this.imageProvider,
      this.child,
      this.paddingBottomOriginal = 70});

  @override
  _ParallaxState createState() => _ParallaxState();
}

class _ParallaxState extends State<Parallax> {
  final _scrollController = ScrollController();
  final _notifyYImage = ValueNotifier<double>(0);
  double _heightImage = 0;

  @override
  void initState() {
    _initScrollControllerListener();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _initHeightImage();
    super.didChangeDependencies();
  }

  void _initHeightImage() {
    _heightImage = Utils.heightInRatio(
        MediaQuery.of(context).size.width, LiveStore.ratioImgApi);
  }

  void _initScrollControllerListener() {
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset < _heightImage)
      _notifyYImage.value = -_scrollController.offset / 3;
  }

  void _deinitScrollControllerListener() {
    _scrollController.removeListener(_scrollListener);
  }

  void _disposeNotifyYImage() {
    _notifyYImage.dispose();
  }

  @override
  void dispose() {
    _deinitScrollControllerListener();
    _disposeNotifyYImage();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedBuilder(
          animation: _notifyYImage,
          child: Image(
            filterQuality: FilterQuality.high,
            image: widget.imageProvider,
          ),
          builder: (_, widget) {
            return Positioned(
              top: _notifyYImage.value,
              left: 0,
              right: 0,
              child: widget,
            );
          },
        ),
        // imageX
        SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          controller: _scrollController,
          child: Column(
            children: <Widget>[
              // Cover imageX
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Colors.black87,
                  Colors.transparent,
                  Colors.transparent
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
                height: _heightImage,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding:
                        EdgeInsets.only(bottom: widget.paddingBottomOriginal),
                    child: Text(
                      widget.originalTitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'AbrilFatface',
                        fontSize: 35,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              widget.child
            ],
          ),
        )
      ],
    );
  }
}

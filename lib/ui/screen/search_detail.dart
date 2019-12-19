import 'package:Anifrag/bloc/bloc_search_detail.dart';
import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/config/path.dart';
import 'package:Anifrag/model/responses/response_movie.dart';
import 'package:Anifrag/model/responses/response_search.dart';
import 'package:Anifrag/ui/widget/parallax.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter_lottie/flutter_lottie.dart';

// class SearchDetail extends AnimatedWidget {

//   SearchDetail({Key key, @required AnimationController controller})
//       : super(key: key, listenable: controller);

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedOp;
//   }
// }

class SearchDetail extends StatefulWidget {
  final Function onGoBack;
  final BlocSearchDetail blocSearchDetail;

  SearchDetail({@required this.onGoBack, @required this.blocSearchDetail});

  @override
  _SearchDetailState createState() => _SearchDetailState();
}

class _SearchDetailState extends State<SearchDetail> {
  // final responseSearch = ResponseSearch(
  //   id: 1,
  //   originalTitle: 'Angel has fallen',
  //   popularity: 12,
  //   posterPath:
  //       'https://image.tmdb.org/t/p/w500/fapXd3v9qTcNBTm39ZC4KUVQDNf.jpg',
  //   releaseDate: DateTime.now(),
  //   runtime: 123,
  // );

  void _goBack() {
    widget.onGoBack();
  }

  // When open Search Detail. didUpdateWidget will pop, not initState
  @override
  void didUpdateWidget(SearchDetail oldWidget) {
    if (!widget.blocSearchDetail.isAlreadyInit) {
      widget.blocSearchDetail.callGetDetail();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    // First time init blocSeachDetail will null
    if (widget.blocSearchDetail != null)
      return ValueListenableBuilder<bool>(
        valueListenable: widget.blocSearchDetail.notifyIsLoading,
        builder: (_, value, ___) {
          return AnimatedCrossFade(
            crossFadeState:
                value ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            duration: Duration(milliseconds: 350),
            layoutBuilder: (first, _, second, __) {
              return Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  Positioned(
                    key: __,
                    left: 0.0,
                    top: 0.0,
                    right: 0.0,
                    bottom: 0.0,
                    child: second,
                  ),
                  Positioned(
                    key: _,
                    child: first,
                  ),
                ],
              );
            },
            firstChild: Center(
              child: SizedBox(
                width: 75,
                height: 75,
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColor.yellow,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: LottieView.fromFile(
                      filePath: PathLottie.loading,
                      autoPlay: true,
                      loop: true,
                      onViewCreated: (controller) {}),
                ),
              ),
            ),
            secondChild: ValueListenableBuilder<
                dartz.Tuple2<SearchDetailState, ResponseMovie>>(
              valueListenable: widget.blocSearchDetail.notifyDetailState,
              builder: (_, tuple2, ___) {
                switch (tuple2.value1) {
                  case SearchDetailState.error:
                  case SearchDetailState.standby:
                    return SizedBox.shrink();

                  default:
                    return Parallax(
                      originalTitle: tuple2.value2.title,
                      imageProvider: NetworkImage(
                          widget.blocSearchDetail.baseUrlImage +
                              tuple2.value2.posterPath),
                      child: InkWell(
                        onTap: () {
                          _goBack();
                        },
                        child: Container(
                          height: 5000,
                          color: Colors.red,
                        ),
                      ),
                    );
                }
              },
            ),
          );
        },
      );
    else {
      return SizedBox.shrink();
    }
    //   _isLoading
    //       ? Center(
    //           child: SizedBox(
    //             width: 75,
    //             height: 75,
    //             child: Container(
    //               decoration: BoxDecoration(
    //                   color: AppColor.yellow,
    //                   borderRadius: BorderRadius.all(Radius.circular(10))),
    //               child: InkWell(
    //                 onTap: () {
    //                   _switchLoading();
    //                 },
    //                 child: LottieView.fromFile(
    //                     filePath: PathLottie.loading,
    //                     autoPlay: true,
    //                     loop: true,
    //                     onViewCreated: (controller) {}),
    //               ),
    //             ),
    //           ),
    //         )
    //       : Parallax(
    //           originalTitle: responseSearch.originalTitle,
    //           imageProvider: NetworkImage(responseSearch.posterPath),
    //           child: InkWell(
    //             onTap: () {
    //               _switchLoading();
    //             },
    //             child: Container(
    //               height: 5000,
    //               color: Colors.red,
    //             ),
    //           ),
    //         ),
    // ),
    // );
  }
}

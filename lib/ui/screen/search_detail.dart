import 'package:Anifrag/bloc/bloc_search_detail.dart';
import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/config/path.dart';
import 'package:Anifrag/model/responses/response_movie.dart';
import 'package:Anifrag/model/responses/response_search.dart';
import 'package:Anifrag/ui/widget/content_search_detail.dart';
import 'package:Anifrag/ui/widget/parallax.dart';
import 'package:Anifrag/ui/widget/serach_view.dart';
import 'package:Anifrag/ui/widget/skuru_panel.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lottie/flutter_lottie.dart';

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

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.blocSearchDetail.notifyIsLoading,
      builder: (_, isLoading, ___) {
        return AnimatedCrossFade(
          crossFadeState:
              isLoading ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: Duration(milliseconds: 400),
          firstCurve: Interval(0.0, 0.5),
          secondCurve: Interval(0.5, 1.0),
          firstChild: Container(
            child: ValueListenableBuilder<
                dartz.Tuple3<SearchDetailState, ResponseMovie, ImageProvider>>(
              valueListenable: widget.blocSearchDetail.notifyDetailState,
              builder: (_, detailStateData, ___) {
                switch (detailStateData.value1) {
                  case SearchDetailState.error:
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        MessageSearchView(
                          message: 'Oh damm. Something wrong.',
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: CupertinoButton(
                            color: AppColor.yellow,
                            onPressed: () {},
                            child: Text('Try again',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                )),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: CupertinoButton(
                            color: AppColor.yellow,
                            onPressed: () {
                              _goBack();
                            },
                            child: Text('Go back',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                )),
                          ),
                        )
                      ],
                    );

                  case SearchDetailState.standby:
                    return Container();

                  default:
                    return Parallax(
                      onTap: () {
                        _goBack();
                      },
                      originalTitle: detailStateData.value2.title,
                      imageProvider: detailStateData.value3,
                      child: ContentSearchDetail(),
                    );
                }
              },
            ),
          ),
          secondChild: Visibility(
            visible: isLoading,
            child: Container(
              color: AppColor.backgroundColor,
              child: Center(
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
            ),
          ),
        );
      },
    );
  }
}

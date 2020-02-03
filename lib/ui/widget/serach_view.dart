import 'dart:io';

import 'package:Anifrag/bloc/bloc_search_view.dart';
import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/config/path.dart';
import 'package:Anifrag/config/utils.dart';
import 'package:Anifrag/di/component.dart';
import 'package:Anifrag/model/responses/response_search.dart';
import 'package:Anifrag/store/live_store.dart';
import 'package:Anifrag/ui/widget/search_item.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'indicator.dart';

class SearchView extends StatelessWidget {
  final Function(int) onItemClick;
  SearchView({@required this.onItemClick});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (ctx) => ComponentInjector.I.blocSearchView,
      child: _SearchView(
        onItemClick: onItemClick,
      ),
    );
  }
}

class _SearchView extends StatefulWidget {
  final Function(int) onItemClick;
  _SearchView({@required this.onItemClick});

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<_SearchView> {
  static const double _heightImgSearchItem = 80;
  double _widthImgSearchItem;
  BlocSearchView _blocSearchView;

  @override
  void initState() {
    _initWidthImage();
    _initBlocSearchView();
    super.initState();
  }

  void _initWidthImage() {
    _widthImgSearchItem =
        Utils.widthInRatio(_heightImgSearchItem, LiveStore.ratioImgApi);
  }

  void _initBlocSearchView() {
    _blocSearchView = Provider.of<BlocSearchView>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: 15, right: 15, top: Platform.isAndroid ? 15 : 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Container(
              constraints: BoxConstraints.expand(height: 50),
              decoration: BoxDecoration(
                  color: AppColor.search,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: SvgPicture.asset(
                      PathSvg.find,
                      color: Colors.grey,
                      height: 20,
                    ),
                  ),
                  Flexible(
                    child: TextFormField(
                      enableInteractiveSelection: false,
                      onChanged: (text) {
                        _blocSearchView.searchMovies(text);
                      },
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search...',
                          hintStyle: TextStyle(color: Colors.grey)),
                      style: TextStyle(color: Colors.grey[50], fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: ValueListenableBuilder<bool>(
                      valueListenable: _blocSearchView.valueNotifyIsLoading,
                      builder: (_, isLoading, ___) {
                        if (isLoading) {
                          return Platform.isAndroid
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Indicator(
                                    strokeAndroid: 3,
                                  ),
                                )
                              : Indicator();
                        }
                        return SizedBox.shrink();
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          Flexible(
              fit: FlexFit.loose,
              child: StreamBuilder<
                  dartz.Tuple2<SearchState, List<ResponseSearch>>>(
                initialData: dartz.Tuple2(SearchState.kickoff, []),
                stream: _blocSearchView.subjectSearchState,
                builder: (_, snapshot) {
                  switch (snapshot.data.value1) {
                    case SearchState.kickoff:
                      return GestureDetector(
                        onTap: () {
                          widget.onItemClick(423204);
                        },
                        child: MessageSearchView(
                          message: 'Find what to watch next.',
                        ),
                      );
                    case SearchState.fulfill:
                      return NotificationListener<ScrollNotification>(
                        onNotification: (notification) {
                          if (notification is ScrollStartNotification) {
                            FocusScope.of(context).unfocus();
                          }
                          return false;
                        },
                        child: ListView.separated(
                          separatorBuilder: (_, index) {
                            return SizedBox(
                              height: 15,
                              width: 1,
                            );
                          },
                          padding: EdgeInsets.only(bottom: 30),
                          itemCount: snapshot.data.value2.length,
                          itemBuilder: (_, index) {
                            return GestureDetector(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                widget.onItemClick(
                                    snapshot.data.value2[index].id);
                              },
                              child: SearchItem(
                                heightImg: _heightImgSearchItem,
                                widthImg: _widthImgSearchItem,
                                posterPath: _blocSearchView.baseUrlImage +
                                    snapshot.data.value2[index].posterPath,
                                popularity: snapshot
                                    .data.value2[index].popularity
                                    .toString(),
                                runtime: snapshot.data.value2[index].runtime,
                                title:
                                    snapshot.data.value2[index].originalTitle,
                                yearRelease:
                                    snapshot.data.value2[index].releaseDate,
                              ),
                            );
                          },
                        ),
                      );
                    default:
                      return MessageSearchView(
                        message: 'Oh damm. We dont have that.',
                      );
                  }
                },
              ))
        ],
      ),
    );
  }
}

class MessageSearchView extends StatelessWidget {
  final String message;

  MessageSearchView({@required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 20),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            this.message == null ? '' : this.message,
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ));
  }
}

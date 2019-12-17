import 'dart:io';

import 'package:Anifrag/bloc/bloc_search.dart';
import 'package:Anifrag/config/app_color.dart';
import 'package:Anifrag/config/mock_data.dart';
import 'package:Anifrag/config/path.dart';
import 'package:Anifrag/config/utils.dart';
import 'package:Anifrag/di/component.dart';
import 'package:Anifrag/model/responses/response_search.dart';
import 'package:Anifrag/store/live_store.dart';
import 'package:Anifrag/ui/screen/search_detail.dart';
import 'package:Anifrag/ui/widget/indicator.dart';
import 'package:Anifrag/ui/widget/search_item.dart';
import 'package:dartz/dartz.dart' as prefix;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with AutomaticKeepAliveClientMixin<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (ctx) => ComponentInjector.I.blocSearch,
      child: _Search(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<_Search> with SingleTickerProviderStateMixin {
  static const double _heightImgSearchItem = 80;
  double _widthImgSearchItem;
  BlocSearch _blocSearch;
  bool _showSearch = true;

  @override
  void initState() {
    _widthImgSearchItem =
        Utils.widthInRatio(_heightImgSearchItem, LiveStore.ratioImgApi);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _blocSearch = Provider.of<BlocSearch>(context, listen: false);
    super.didChangeDependencies();
  }

  void _swtichDetail() => setState(() {
        _showSearch = !_showSearch;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: SafeArea(
            bottom: false,
            child: AnimatedCrossFade(
                duration: Duration(milliseconds: 250),
                crossFadeState: _showSearch
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
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
                secondChild: SearchDetail(
                  onTap: () {
                    _swtichDetail();
                  },
                ),
                firstChild: Padding(
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
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
                                  // inputFormatters: [
                                  //   WhitelistingTextInputFormatter.digitsOnly
                                  // ],
                                  enableInteractiveSelection: false,
                                  onChanged: (text) {
                                    _blocSearch.searchMovies(text);
                                  },
                                  cursorColor: Colors.grey,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Search...',
                                      hintStyle: TextStyle(color: Colors.grey)),
                                  style: TextStyle(
                                      color: Colors.grey[50], fontSize: 20),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: ValueListenableBuilder<bool>(
                                  valueListenable:
                                      _blocSearch.valueNotifyIsLoading,
                                  builder: (_, isLoading, ___) {
                                    if (isLoading) return Indicator();

                                    return SizedBox();
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
                              prefix.Tuple2<SearchState, List<ResponseSearch>>>(
                            initialData: prefix.Tuple2(SearchState.kickoff, []),
                            stream: _blocSearch.subjectSearchState,
                            builder: (_, snapshot) {
                              switch (snapshot.data.value1) {
                                case SearchState.kickoff:
                                  return GestureDetector(
                                    onTap: () {
                                      _swtichDetail();
                                    },
                                    child: _MessageView(
                                      message: 'Find what to watch next.',
                                    ),
                                  );
                                case SearchState.fulfill:
                                  return NotificationListener<
                                      ScrollNotification>(
                                    onNotification: (notification) {
                                      if (notification
                                          is ScrollStartNotification) {
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
                                        return SearchItem(
                                          heightImg: _heightImgSearchItem,
                                          widthImg: _widthImgSearchItem,
                                          posterPath:
                                              _blocSearch.getBaseUrlImage +
                                                  snapshot.data.value2[index]
                                                      .posterPath,
                                          popularity: snapshot
                                              .data.value2[index].popularity
                                              .toString(),
                                          runtime: snapshot
                                              .data.value2[index].runtime,
                                          title: snapshot
                                              .data.value2[index].originalTitle,
                                          yearRelease: snapshot
                                              .data.value2[index].releaseDate,
                                        );
                                      },
                                    ),
                                  );
                                default:
                                  return _MessageView(
                                    message: 'Oh damm. We dont have that.',
                                  );
                              }
                            },
                          ))
                    ],
                  ),
                ))));
  }
}

class _MessageView extends StatelessWidget {
  final String message;

  _MessageView({@required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 10),
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

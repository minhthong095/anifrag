import 'package:Anifrag/bloc/bloc_search_detail.dart';
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
import 'package:Anifrag/ui/widget/serach_view.dart';
import 'package:dartz/dartz.dart' as prefix;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<SearchScreen>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<SearchScreen> {
  bool _isShowDetail = false;
  BlocSearchDetail _blocSearchDetail;

  void _showDetail(int idMovie) {
    if (_isShowDetail == false) _blocSearchDetail.callGetDetail(idMovie);
    setState(() {
      _isShowDetail = true;
    });
  }

  void _showSearch() {
    setState(() {
      _isShowDetail = false;
    });
  }

  @override
  void initState() {
    _blocSearchDetail = ComponentInjector.I.blocSearchDetail;
    super.initState();
  }

  @override
  void dispose() {
    _blocSearchDetail.dispose();
    super.dispose();
  }

  //TODO: CHECK MEMORY FOR POPIN POPOUT SEARCH DETAIL
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: SafeArea(
            bottom: false,
            child: AnimatedCrossFade(
              layoutBuilder: (topChild, topKey, bottomChild, bottomKey) {
                return Stack(
                  children: <Widget>[
                    bottomChild,
                    topChild,
                  ],
                );
              },
              crossFadeState: _isShowDetail
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              firstCurve: Interval(0.0, 0.5),
              firstChild: SearchView(
                onItemClick: (idMovie) {
                  _showDetail(idMovie);
                },
              ),
              secondCurve: Interval(0.5, 1),
              secondChild: SearchDetail(
                blocSearchDetail: _blocSearchDetail,
                onGoBack: () {
                  _showSearch();
                },
              ),
              duration: Duration(milliseconds: 450),
            )));
  }

  @override
  bool get wantKeepAlive => true;
}

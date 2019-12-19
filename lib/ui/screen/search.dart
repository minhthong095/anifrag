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
  int _selectedIdMovie;
  int _lastSelectedIdMovie;

  void _renewBlocSearchDetail() {
    if (_isShowDetail == true && _selectedIdMovie != _lastSelectedIdMovie) {
      _blocSearchDetail = ComponentInjector.I.blocSearchDetail;
      _blocSearchDetail.setIdMovie = _selectedIdMovie;
    }
  }

  void _showDetail(int idMovie) {
    _lastSelectedIdMovie = _selectedIdMovie;
    setState(() {
      _isShowDetail = true;
      _selectedIdMovie = idMovie;
    });
  }

  void _showSearch() {
    setState(() {
      _isShowDetail = false;
    });
  }

  //TODO: CHECK MEMORY FOR POPIN POPOUT SEARCH DETAIL
  @override
  Widget build(BuildContext context) {
    _renewBlocSearchDetail();
    return Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: SafeArea(
            bottom: false,
            child: AnimatedCrossFade(
              crossFadeState: _isShowDetail
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              firstChild: SearchView(
                onItemClick: (idMovie) {
                  _showDetail(idMovie);
                },
              ),
              secondChild: SearchDetail(
                blocSearchDetail: _blocSearchDetail,
                onGoBack: () {
                  _showSearch();
                },
              ),
              duration: Duration(milliseconds: 250),
            )));
  }

  @override
  bool get wantKeepAlive => true;
}

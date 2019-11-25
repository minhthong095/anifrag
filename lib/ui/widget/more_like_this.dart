import 'package:Anifrag/bloc/bloc_detail.dart';
import 'package:Anifrag/bloc/bloc_home.dart';
import 'package:Anifrag/config/mock_data.dart';
import 'package:Anifrag/model/responses/response_home_page_movie.dart';
import 'package:Anifrag/ui/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'empty_image.dart';
import 'hero_image.dart';

class MoreLikeThis extends StatefulWidget {
  @override
  _MoreLikeThisState createState() => _MoreLikeThisState();
}

class _MoreLikeThisState extends State<MoreLikeThis> {
  BlocDetail _blocDetail;
  BlocHome _blocHome;
  OnItemTap _onItemTap;
  List<ResponseThumbnailMovie> _moreLikeThis;

  @override
  void didChangeDependencies() {
    _initBlocDetail();
    _blocHome = Provider.of<BlocHome>(context);
    _onItemTap = (int idMovie, String prefix) {
      _blocHome.moveDetailProcess(context, idMovie, prefix);
    };
    super.didChangeDependencies();
  }

  void _initBlocDetail() {
    _blocDetail = Provider.of<BlocDetail>(context);
    _blocDetail.setCallbackDoneMoreLikeThis = (moreLikeThis) {
      setState(() {
        _moreLikeThis = moreLikeThis;
      });
    };
  }

  Widget _defaultMoreLikeThis() => GridView.count(
        shrinkWrap: true,
        crossAxisCount: 3,
        childAspectRatio: 324 / 480,
        crossAxisSpacing: 20,
        padding: EdgeInsets.zero,
        physics: ClampingScrollPhysics(),
        mainAxisSpacing: 10,
        children: List.generate(6, (index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(7.0),
            child: EmptyImage(),
          );
        }),
      );

  @override
  Widget build(BuildContext context) {
    if (_moreLikeThis != null && _moreLikeThis.length > 0) {
      return GridView.count(
        shrinkWrap: true,
        crossAxisCount: 3,
        childAspectRatio: 324 / 480,
        crossAxisSpacing: 20,
        padding: EdgeInsets.zero,
        physics: ClampingScrollPhysics(),
        mainAxisSpacing: 10,
        children: List.generate(_moreLikeThis.length, (index) {
          return GestureDetector(
            onTap: () {
              _onItemTap(_moreLikeThis[index].id, 'MoreLikeThis');
            },
            child: HeroImage(
              emptyMode: false,
              path: _blocDetail.baseUrlImage + _moreLikeThis[index].posterPath,
              tag: 'MoreLikeThis' + _moreLikeThis[index].posterPath,
            ),
          );
        }),
      );
    } else
      return _defaultMoreLikeThis();
  }
  // _defaultMoreLikeThis();
}

// List.generate(MockData.listImage.length, (index) {
//           return HeroImage(
//             emptyMode: true,
//             path: MockData.listImage[index],
//             tag: MockData.listImage[index],
//           );
//         })

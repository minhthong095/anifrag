import 'package:Anifrag/bloc/bloc_detail.dart';
import 'package:Anifrag/bloc/bloc_home.dart';
import 'package:Anifrag/config/mock_data.dart';
import 'package:Anifrag/config/utils.dart';
import 'package:Anifrag/model/responses/response_home_page_movie.dart';
import 'package:Anifrag/store/live_store.dart';
import 'package:Anifrag/ui/mixin/mixin_move_detail.dart';
import 'package:Anifrag/ui/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'empty_image.dart';
import 'hero_image.dart';

class MoreLikeThis extends StatefulWidget {
  @override
  _MoreLikeThisState createState() => _MoreLikeThisState();
}

class _MoreLikeThisState extends State<MoreLikeThis> with MoveDetailMixin {
  BlocDetail _blocDetail;
  BlocHome _blocHome;
  OnItemTap _onItemTap;
  List<ResponseThumbnailMovie> _moreLikeThis;
  double _widthImg = 0;
  static const double _preferHeightImg = 150;

  @override
  void didChangeDependencies() {
    _initBlocDetail();
    _blocHome = Provider.of<BlocHome>(context, listen: false);
    _onItemTap = (int idMovie, String prefix) {
      _blocHome.moveDetailProcess(idMovie, prefix);
    };
    _widthImg = Utils.widthInRatio(_preferHeightImg, LiveStore.ratioImgApi);
    initListenerMoveToDetailState(context, _blocHome);
    super.didChangeDependencies();
  }

  void _initBlocDetail() {
    _blocDetail = Provider.of<BlocDetail>(context, listen: false);
    _blocDetail.setCallbackDoneMoreLikeThis = (moreLikeThis) {
      setState(() {
        _moreLikeThis = moreLikeThis;
      });
    };
  }

  Widget _defaultMoreLikeThis() => _gridFrame(List.generate(6, (index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(7.0),
          child: EmptyImage(
            height: _preferHeightImg,
            width: _widthImg,
          ),
        );
      }));

  Widget _gridFrame(List<Widget> children) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      crossAxisSpacing: 20,
      padding: EdgeInsets.zero,
      childAspectRatio: LiveStore.ratioImgApi,
      physics: ClampingScrollPhysics(),
      mainAxisSpacing: 10,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_moreLikeThis != null && _moreLikeThis.length > 0) {
      return _gridFrame(List.generate(_moreLikeThis.length, (index) {
        return GestureDetector(
          onTap: () {
            _onItemTap(_moreLikeThis[index].id, 'MLT');
          },
          child: HeroImage(
            width: _widthImg,
            height: _preferHeightImg,
            fit: BoxFit.fill,
            emptyMode: false,
            path: _blocDetail.baseUrlImage + _moreLikeThis[index].posterPath,
            tag: 'MoreLikeThis' + _moreLikeThis[index].posterPath,
          ),
        );
      }));
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

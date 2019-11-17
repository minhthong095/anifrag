import 'package:Anifrag/bloc/bloc_detail.dart';
import 'package:Anifrag/config/mock_data.dart';
import 'package:Anifrag/model/responses/response_home_page_movie.dart';
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

  @override
  void didChangeDependencies() {
    _blocDetail = Provider.of<BlocDetail>(context);
    _blocDetail.callMoreLikeThis();
    super.didChangeDependencies();
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
  void dispose() {
    _blocDetail.dipose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder(
        stream: _blocDetail.subjectMoreLikeThis,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final List<ResponseThumbnailMovie> moreLikeThisList = snapshot.data;
            return GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              childAspectRatio: 324 / 480,
              crossAxisSpacing: 20,
              padding: EdgeInsets.zero,
              physics: ClampingScrollPhysics(),
              mainAxisSpacing: 10,
              children: List.generate(moreLikeThisList.length, (index) {
                return HeroImage(
                  emptyMode: false,
                  path: _blocDetail.baseUrlImg() +
                      moreLikeThisList[index].posterPath,
                  tag: 'MoreLikeThis' + moreLikeThisList[index].posterPath,
                );
              }),
            );
          } else
            return _defaultMoreLikeThis();
        },
      );
}

// List.generate(MockData.listImage.length, (index) {
//           return HeroImage(
//             emptyMode: true,
//             path: MockData.listImage[index],
//             tag: MockData.listImage[index],
//           );
//         })

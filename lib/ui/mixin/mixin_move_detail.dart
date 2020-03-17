import 'package:Anifrag/bloc/bloc_home.dart';
import 'package:Anifrag/model/business/business_movie.dart';
import 'package:Anifrag/model/responses/response_cast.dart';
import 'package:Anifrag/ui/screen/detail.dart';
import 'package:Anifrag/ui/widget/loading_route.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/cupertino.dart';

mixin MoveDetailMixin {
  void initListenerMoveToDetailState(BuildContext context, BlocHome blocHome) {
    blocHome.subjectMoveDetailState.listen((dartz.Either<MoveDetailState,
            dartz.Tuple4<BusinessMovie, List<ResponseCast>, bool, String>>
        moveDetailState) {
      moveDetailState.fold((ifLeft) {
        return LoadingRoute2.raise(context);
      }, (ifRight) {
        LoadingRoute2.fall();
        if (ifRight.value3) {
          Navigator.of(context).pushNamed(DetailScreen.nameRoute,
              arguments: DetailScreenArgument(
                  ifRight.value4, ifRight.value1, ifRight.value2));
        }
      });
    });
  }
}

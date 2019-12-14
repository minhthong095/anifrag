import 'package:Anifrag/bloc/bloc_home.dart';
import 'package:Anifrag/model/responses/response_cast.dart';
import 'package:Anifrag/model/responses/response_movie.dart';
import 'package:Anifrag/ui/screen/detail.dart';
import 'package:Anifrag/ui/widget/loading_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:dartz/dartz.dart' as dartz;

mixin MoveDetailMixin {
  void initListenerMoveToDetailState(BuildContext context, BlocHome blocHome) {
    blocHome.subjectMoveDetailState.listen((dartz.Either<MoveDetailState,
            dartz.Tuple4<ResponseMovie, List<ResponseCast>, bool, String>>
        moveDetailState) {
      moveDetailState.fold(
          (ifLeft) => Navigator.of(context).pushNamed(LoadingRoute.nameRoute),
          (ifRight) {
        Navigator.of(context).popUntil(LoadingRoute.loadingRoutePredicate());
        if (ifRight.value3) {
          Navigator.of(context).pushNamed(DetailScreen.nameRoute,
              arguments: DetailScreenArgument(
                  ifRight.value4, ifRight.value1, ifRight.value2));
        }
      });
    });
  }
}

import 'package:Anifrag/bloc/dispose_bag.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/subjects.dart';

@provide
class BlocMainTabbar with DisposeBag {
  // ignore: close_sinks
  final statePopup = PublishSubject<Duration>();

  BlocMainTabbar() {
    dropStream(statePopup);
  }

  void triggerPopup() {
    statePopup.sink.add(Duration(seconds: 1));
  }

  void triggerPopupLong() {
    statePopup.sink.add(Duration(seconds: 5));
  }
}

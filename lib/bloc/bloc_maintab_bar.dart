import 'dart:ui';

import 'package:Anifrag/bloc/dispose_bag.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/subjects.dart';

@provide
class BlocMainTabbar with DisposeBag {
  // ignore: close_sinks
  final subjectPopup = PublishSubject<Duration>();

  BlocMainTabbar() {
    dropStream(subjectPopup);
  }

  void triggerPopup() {
    subjectPopup.sink.add(Duration(seconds: 1));
  }

  void triggerPopupLong() {
    subjectPopup.sink.add(Duration(seconds: 5));
  }
}

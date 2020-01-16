import 'dart:ui';

import 'package:Anifrag/bloc/dispose_bag.dart';
import 'package:rxdart/subjects.dart';

class BlocMainTabbar with DisposeBag {
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

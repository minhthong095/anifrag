import 'dart:ui';

import 'package:rxdart/subjects.dart';

class BlocMainTabbar {
  final subjectPopup = PublishSubject<Duration>();

  void triggerPopup() {
    subjectPopup.sink.add(Duration(seconds: 1));
  }

  void triggerPopupLong() {
    subjectPopup.sink.add(Duration(seconds: 5));
  }

  void dispose() {
    subjectPopup.close();
  }
}

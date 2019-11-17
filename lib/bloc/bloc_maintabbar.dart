import 'dart:ui';

import 'package:rxdart/subjects.dart';

class BlocMainTabbar {
  final subjectPopup = PublishSubject<int>();

  void triggerPopup() {
    subjectPopup.sink.add(1);
  }

  void triggerPopupLong() {
    subjectPopup.sink.add(5);
  }

  void dispose() {
    subjectPopup.close();
  }
}

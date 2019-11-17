import 'dart:ui';

import 'package:rxdart/subjects.dart';

class BlocMainTabbar {
  final subjectPopup = PublishSubject<int>();

  void triggerPopup() {
    subjectPopup.sink.add(1);
  }

  void dispose() {
    subjectPopup.close();
  }
}

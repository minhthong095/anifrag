import 'package:flutter/rendering.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

import 'dispose_bag.dart';

class BlocCarousel extends DisposeBag {
  static final String defaultOffset = "0.0";
  static final bool defaultHaveDimension = false;
  static final ScrollDirection defaultScrollDirection = ScrollDirection.idle;
  static final int defaultIndex = 0;

  BehaviorSubject<String> _behaviorOffset =
      BehaviorSubject.seeded(defaultOffset);
  BehaviorSubject<ScrollDirection> _behaviorScrollDirection =
      BehaviorSubject.seeded(defaultScrollDirection);
  BehaviorSubject<bool> _behaviorHaveDimension =
      BehaviorSubject.seeded(defaultHaveDimension);
  BehaviorSubject<String> _behaviorIndex =
      BehaviorSubject.seeded(defaultIndex.toString());

  Observable<String> get offset => _behaviorOffset.stream;
  Observable<ScrollDirection> get scrollDirection =>
      _behaviorScrollDirection.stream;
  Observable<bool> get haveDimension => _behaviorHaveDimension.stream;
  Observable<String> get index => _behaviorIndex.stream;

  void sendOffset(double offset) {
    _behaviorOffset.sink.add(offset.toString());
  }

  void sendScrollDirection(ScrollDirection scrollDirection) {
    _behaviorScrollDirection.sink.add(scrollDirection);
  }

  void sendHaveDimension(bool haveDimension) {
    _behaviorHaveDimension.sink.add(haveDimension);
  }

  void sendIndex(double index) {
    _behaviorIndex.sink.add(index.toString());
  }

  @override
  void dispose() {
    dropStream(_behaviorOffset);
    dropStream(_behaviorScrollDirection);
    dropStream(_behaviorHaveDimension);
    dropStream(_behaviorIndex);
    super.dispose();
  }
}

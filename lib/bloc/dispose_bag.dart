import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

mixin DisposeBag {
  final _subscriptionBag = CompositeSubscription();
  final _streamBag = _StreamBag();
  final _notifierBag = _StreamChangeNotifier();

  void dropSubscription(StreamSubscription<dynamic> subscription) {
    _subscriptionBag.add(subscription);
  }

  void dropStream(Sink stream) {
    _streamBag.add(stream);
  }

  void dropNotifier(ChangeNotifier notifier) {
    _notifierBag.add(notifier);
  }

  void dispose() {
    _subscriptionBag.dispose();
    _streamBag.dispose();
    _notifierBag.dispose();
  }
}

class _StreamBag extends _Bag<Sink> {
  @override
  void executeDelete(Sink evidence) {
    evidence.close();
  }
}

class _StreamChangeNotifier extends _Bag<ValueNotifier> {
  @override
  void executeDelete(ValueNotifier evidence) {
    evidence.dispose();
  }
}

abstract class _Bag<T> {
  bool _isDisposed = false;
  final List<T> _streamBag = <T>[];

  bool get isDisposed => _isDisposed;

  void add(T stream) {
    if (isDisposed) {
      throw ("This stream bag was disposed, try to use new instance instead.");
    }
    _streamBag.add(stream);
  }

  void executeDelete(T evidence);

  void dispose() {
    _streamBag.forEach((stream) {
      executeDelete(stream);
    });
    _streamBag.clear();
    _isDisposed = true;
  }
}

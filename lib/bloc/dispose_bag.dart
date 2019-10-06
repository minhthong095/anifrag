import 'dart:async';

import 'package:rxdart/rxdart.dart';

abstract class DisposeBag {
  final _subscriptionBag = CompositeSubscription();
  final _streamBag = _StreamBag();

  void dropSubscription(StreamSubscription<dynamic> subscription) {
    _subscriptionBag.add(subscription);
  }

  void dropStream(Sink stream) {
    _streamBag.add(stream);
  }

  void dispose() {
    _subscriptionBag.dispose();
    _streamBag.dispose();
  }
}

class _StreamBag {
  bool _isDisposed = false;
  final List<Sink> _streamBag = <Sink>[];

  bool get isDisposed => _isDisposed;

  void add(Sink stream) {
    if (isDisposed) {
      throw ("This stream bag was disposed, try to use new instance instead");
    }
    _streamBag.add(stream);
  }

  void dispose() {
    _streamBag.forEach((stream) {
      stream.close();
    });
    _streamBag.clear();
    _isDisposed = true;
  }
}

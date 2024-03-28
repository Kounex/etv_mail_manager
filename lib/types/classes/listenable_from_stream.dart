import 'dart:async';

import 'package:flutter/foundation.dart';

class ListenableFromStream<T> extends ChangeNotifier {
  ListenableFromStream(Stream<T> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (_) => notifyListeners(),
        );
  }

  late final StreamSubscription<T> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

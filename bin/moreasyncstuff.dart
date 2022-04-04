import 'dart:async';

class StreamHolder {
  final _integerStreamController = StreamController<int>()
    ..onListen = (() => print("listening"))
    ..onCancel = (() => print("cancelled"));

  late final _broadcastStream = _integerStreamController.stream.asBroadcastStream();

  Stream<int> get integerYieldingStream async* {
    yield 2;
    yield* _broadcastStream;
  }

  Stream<int> get integerStream {
    return _broadcastStream;
  }

  void doIt() {
    _integerStreamController.add(1);
  }
}

void main() {
  final streamHolder = StreamHolder();

  streamHolder.doIt();

  streamHolder.integerYieldingStream.listen((integer) => print("integerYieldingStream: $integer"));

  streamHolder.integerYieldingStream
      .listen((integer) => print("integerYieldingStream 2: $integer"));

  streamHolder.integerStream.listen((integer) => print("integerStream: $integer"));

  streamHolder.integerStream.listen((integer) => print("integerStream 2: $integer"));

  streamHolder.doIt();
  streamHolder.doIt();
}

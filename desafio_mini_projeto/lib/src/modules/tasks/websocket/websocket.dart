import 'dart:async';

class StreamWebSocket {
  final _streamSocketResponse = StreamController<String>();

  void Function(String) get addResponse => _streamSocketResponse.sink.add;

  Stream<String> get getResponse => _streamSocketResponse.stream;

  void dispose() {
    _streamSocketResponse.close();
  }
}

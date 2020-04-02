import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class StreamData<T> {
  T _value;

  StreamData(T initialData) {
    _value = initialData;
  }

  final StreamController<T> _controller = StreamController.broadcast();


  /// Return a stream of <T>
  Stream<T> get stream => _controller.stream;

  /// Return current value of stream
  T get value => _value;

  @override
  String toString() {
    return "StreamData{$_value}";
  }

  /// Listen to each change from stream
  void listen(onData(T event)) {
    stream.listen(onData);
  }

  /// Set data to stream
  void setData(T data) {
    _value = data;
    _controller.sink.add(_value);
  }

  /// Close the stream
  void dispose() {
    _controller?.close();
  }
}

createStreamWidget<T>({
  @required StreamData<T> streamData,
  @required Function(BuildContext context, T value) buildChild,
}) {
  return StreamBuilder(
    stream: streamData.stream,
    initialData: streamData.value,
    builder: (context, snapshot) {
      return buildChild(context, snapshot.data);
    },
  );
}
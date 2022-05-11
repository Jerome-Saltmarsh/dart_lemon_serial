
import 'dart:convert' show utf8;
import 'dart:typed_data';


class ByteWriter {
  var _index = 0;
  final _buffer = Uint8List(70000);
  final _buffers = <int, Uint8List>{};

  List<int> writeToSendBuffer() {
    final sendBuffer = _getSendBuffer();
    for (var i = 0; i < _index; i++) {
      sendBuffer[i] = _buffer[i];
    }
    _index = 0;
    return sendBuffer;
  }

  void writeBool(bool value){
    writeByte(value ? 1 : 0);
  }

  void writeString(String value){
    writeInt(value.length);
    if (value.length == 0) return;
    final encoded = utf8.encode(value);
    for(final character in encoded){
      writeByte(character);
    }
  }

  List<int> _getSendBuffer() {
    final bufferIndex = _index ~/ 100;
    final buffer = _buffers[bufferIndex];
    if (buffer != null) return buffer;
    final newBufferLength = (bufferIndex + 1) * 100;
    final newBuffer = Uint8List(newBufferLength);
    _buffers[bufferIndex] = newBuffer;
    return newBuffer;
  }

  /// A positive int can be up to 256^2
  void writePositiveInt(num value){
    writeByte(value ~/ 256);
    writeByte(value.toInt() % 256);
  }

  void writeInt(num value){
    final abs = value.toInt().abs();
    writeByte((value >= 0 ? 100 : 0) + abs ~/ 100);
    writeByte(abs % 100);
  }

  void writeByte(int value){
    assert(value <= 256);
    assert(value >= 0);
    _buffer[_index++] = value;
  }
}

import 'dart:convert' show utf8;
import 'dart:typed_data';


class ByteWriter {
  var _index = 0;
  final _buffer = Uint8List(70000);
  final _buffers = <int, Uint8List>{};

  final _buffer75 = Uint8List(75);
  final _buffer100 = Uint8List(100);
  final _buffer150 = Uint8List(150);
  final _buffer200 = Uint8List(200);

  Uint8List writeToSendBuffer() {
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

  Uint8List _getSendBuffer() {
    if (_index < 75) return _buffer75;
    if (_index < 100) return _buffer100;
    if (_index < 150) return _buffer150;
    if (_index < 200) return _buffer200;

    final bufferIndex = _index ~/ 100;
    final buffer = _buffers[bufferIndex];
    if (buffer != null) return buffer;
    final newBufferLength = (bufferIndex + 1) * 100;
    final newBuffer = Uint8List(newBufferLength);
    _buffers[bufferIndex] = newBuffer;
    return newBuffer;
  }

  void writeUInt16(int value){
    writeByte(value ~/ 256);
    writeByte(value % 256);
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
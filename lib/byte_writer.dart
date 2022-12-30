
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
  final _buffer300 = Uint8List(300);

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
    writeUInt16(value.length);
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
    if (_index < 300) return _buffer300;

    final bufferIndex = _index ~/ 100;
    final buffer = _buffers[bufferIndex];
    if (buffer != null) return buffer;
    final newBufferLength = (bufferIndex + 1) * 100;
    final newBuffer = Uint8List(newBufferLength);
    _buffers[bufferIndex] = newBuffer;
    return newBuffer;
  }

  void writeUint16List(List<int> values) {
    final length = values.length;
     for (var i = 0; i < length; i++) {
       writeUInt16(values[i]);
     }
  }

  void writeUDouble16(double value){
    writeUInt16(value.toInt());
  }

  /// writes a signed integer between -127 and 127 using 2 bytes
  void writeInt8(int value){
    assert (value > -128);
    assert (value <  128);
    if (value < 0) {
      writeUInt8(-value);
    } else {
      writeUInt8(value | 0x80);
    }
  }

  /// writes a signed integer between -32768 and 32768 using 2 bytes
  void writeInt16(int value){
     assert (value > -32768);
     assert (value <  32768);

     if (value > 0) {
       writeUInt8(((value >> 8) & 0xff | 0x80));
       writeUInt8((value & 0xff));
     } else {
       writeUInt8((-value >> 8) & 0x7f);
       writeUInt8((-value & 0xff));
     }
  }

  /// writes an unsigned integer
  /// max value is 65536
  void writeUInt16(int value){
    assert (value < 65536);
    assert (value >= 0000);
    writeByte((value & 0xFF00) >> 8);
    writeByte((value & 0xff));
  }

  // void writeInt(num value){
  //   final abs = value.toInt().abs();
  //   writeByte((value >= 0 ? 100 : 0) + abs ~/ 100);
  //   writeByte(abs % 100);
  // }

  void writeBytes(List<int> bytes) {
    final length = bytes.length;
    for (var i = 0; i < length; i++){
      writeByte(bytes[i]);
    }
  }

  void writeByte(int value){
    assert(value <= 256);
    assert(value >= 0);
    _buffer[_index++] = value;
  }


  void writeUInt8(int value){
    assert(value <= 256);
    assert(value >= 0);
    _buffer[_index++] = value;
  }

  void resetIndex(){
    _index = 0;
  }

  Uint8List compile(){
    final compiled = Uint8List(_index);
    for (var i = 0; i < _index; i++){
      compiled[i] = _buffer[i];
    }
    return compiled;
  }
}
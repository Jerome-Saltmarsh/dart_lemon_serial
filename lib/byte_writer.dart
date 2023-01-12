
import 'dart:convert' show utf8;
import 'dart:typed_data';


class ByteWriter {
  final _builder = BytesBuilder();

  void writeBool(bool value) => writeUInt8(value ? 1 : 0);

  void clear() => _builder.clear();

  void writeString(String value){
    writeUInt16(value.length);
    if (value.length == 0) return;
    final encoded = utf8.encode(value);
    for(final character in encoded){
      writeUInt8(character);
    }
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

  /// writes a 16 bit unsigned integer with a max value of 65536
  void writeUInt16(int value){
    assert (value < 65536);
    assert (value >= 0000);
    writeUInt8((value & 0xFF00) >> 8);
    writeUInt8((value & 0xff));
  }

  /// writes a 24 bit unsigned integer with a max value of 16777216
  void writeUInt24(int value){
    assert (value < 16777216);
    assert (value >= 0000);
    writeUInt8((value >> 16) & 0xff);
    writeUInt8((value >> 08) & 0xff);
    writeUInt8((value & 0xff));
  }

  void writeBytes(List<int> bytes) => _builder.add(bytes);

  void writeByte(int value){
    assert(value <= 256);
    assert(value >= 0);
    _builder.addByte(value);
  }

  void writeUInt8(int value){
    assert(value <= 256);
    assert(value >= 0);
    _builder.addByte(value);
  }

  Uint8List compile() => _builder.takeBytes();
}
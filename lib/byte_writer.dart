import 'dart:convert' show utf8;
import 'dart:typed_data';

mixin class ByteWriter {
  final _builder = BytesBuilder();

  void writeBool(bool value) => writeUInt8(value ? 1 : 0);

  void clear() => _builder.clear();

  void writeString(String value) {
    final length = value.length;
    writeUInt16(length);
    if (length == 0) return;
    writeUint8List(utf8.encode(value));
  }

  void writeUint8List(List<int> values) => _builder.add(values);

  void writeUint16List(List<int> values) {
    final length = values.length;
    for (var i = 0; i < length; i++) {
      writeUInt16(values[i]);
    }
  }

  void writeUint24List(List<int> values) {
    final length = values.length;
    for (var i = 0; i < length; i++) {
      writeUInt24(values[i]);
    }
  }

  void writeUint32List(List<int> values) {
    final length = values.length;
    for (var i = 0; i < length; i++) {
      writeUInt32(values[i]);
    }
  }

  void writeInt8(int value) {
    assert(value > -128);
    assert(value < 128);
    if (value < 0) {
      writeUInt8(-value);
    } else {
      writeUInt8(value | 0x80);
    }
  }

  void writeInt16(int value) {
    assert(value > -32768);
    assert(value < 32768);
    if (value > 0) {
      writeUInt8(((value >> 8) & 0xff | 0x80));
      writeUInt8((value & 0xff));
    } else {
      writeUInt8((-value >> 8) & 0x7f);
      writeUInt8((-value & 0xff));
    }
  }

  void writeUInt16(int value) {
    assert(value < 65536);
    assert(value >= 0);
    writeUInt8((value & 0xFF00) >> 8);
    writeUInt8((value & 0xff));
  }

  void writeUInt24(int value) {
    assert(value < 16777216);
    assert(value >= 0);
    writeUInt8((value >> 16) & 0xff);
    writeUInt8((value >> 8) & 0xff);
    writeUInt8((value & 0xff));
  }

  void writeUInt32(int value) {
    assert(value >= 0);
    writeUInt8((value >> 24) & 0xff);
    writeUInt8((value >> 16) & 0xff);
    writeUInt8((value >> 8) & 0xff);
    writeUInt8((value & 0xff));
  }

  void writeBytes(List<int> bytes) => _builder.add(bytes);

  void writeByte(int value) {
    assert(value <= 256);
    assert(value >= 0);
    _builder.addByte(value);
  }

  void writeUInt8(int value) {
    assert(value <= 256);
    assert(value >= 0);
    _builder.addByte(value);
  }

  Uint8List compile() => _builder.takeBytes();
}

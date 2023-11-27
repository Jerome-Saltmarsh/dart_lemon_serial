import 'dart:convert';
import 'dart:typed_data';

mixin class ByteReader {
  var index = 0;
  late List<int> values;

  bool readBool() => readByte() == 1;

  Uint8List readUint8List(int length) {
    final values = Uint8List(length);
    for (var i = 0; i < length; i++) {
      values[i] = readUInt8();
    }
    return values;
  }

  Uint16List readUint16List(int length) {
    final values = Uint16List(length);
    for (var i = 0; i < length; i++) {
      values[i] = readUInt16();
    }
    return values;
  }

  List<int> readUint24List(int length) {
    final values = Uint32List(length);
    for (var i = 0; i < length; i++) {
      values[i] = readUInt24();
    }
    return values;
  }

  Uint32List readUint32List(int length) {
    final values = Uint32List(length);
    for (var i = 0; i < length; i++) {
      values[i] = readUInt32();
    }
    return values;
  }

  int readUInt16() => (readByte() << 8) + readByte();

  int readUInt24() =>
      (readByte() << 16) + (readByte() << 8) + readByte();

  int readUInt32() =>
      (readByte() << 24) +
      (readByte() << 16) +
      (readByte() << 8) +
      readByte();

  int readInt8() {
    final value = readUInt8();
    return (value > 127) ? (value & 0x7F) : -value;
  }

  int readInt16() {
    final a = readByte();
    final b = readByte();
    return (a > 127) ? ((a & 0x7F) << 8) + b : -((a << 8) + b);
  }

  String readString() {
    final length = readUInt16();
    if (length == 0) return "";
    final start = index;
    index += length;
    return utf8.decode(values.sublist(start, start + length));
  }

  Uint8List readBytes(int length) {
    final bytes = Uint8List.view(Uint8List.fromList(values).buffer, index, length);
    index += length;
    return bytes;
  }

  int readByte() => values[index++];

  int readUInt8() {
    return values[index++];
  }
}
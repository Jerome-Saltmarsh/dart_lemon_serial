
import 'dart:convert';
import 'dart:typed_data';

class ByteReader {
  var index = 0;
  late Uint8List values;

  bool readBool() => readByte() == 1;

  int readInt(){
    assert (index < values.length + 1);
    final a = readByte();
    return (a < 100 ? -1 : 1) * ((a % 100) * 100 + readByte());
  }

  int readUInt16() =>(readByte() * 256) + readByte();

  double readDouble() => readInt().toDouble();

  String readString() {
    final length = readInt();
    if (length == 0) return "";
    assert (index + length < values.length);
    final start = index;
    index += length;
    return utf8.decode(values.sublist(start, start + length));
  }

  int readByte(){
    assert (index < values.length);
    index++;
    return values[index - 1];
  }
}
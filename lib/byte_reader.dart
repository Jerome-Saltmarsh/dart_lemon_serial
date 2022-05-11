
import 'dart:convert';

class ByteReader {
  var index = 0;
  var values = <int>[];

  bool readBool(){
    return readByte() == 1;
  }

  int readInt(){
    assert (index < values.length + 1);
    final a = readByte();
    return (a < 100 ? -1 : 1) * ((a % 100) * 100 + readByte());
  }

  int readPositiveInt(){
    return (readByte() * 256) + readByte();
  }

  double readDouble(){
    return readInt().toDouble();
  }

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
    return values[index++];
  }
}

import 'dart:convert';

class ByteReader {
  var index = 0;
  var values = <int>[];

  int readByte(){
    return values[index++];
  }

  bool readBool(){
    return readByte() == 1;
  }

  int readInt(){
    final a = values[index];
    final value = (a < 100 ? -1 : 1) * ((a % 100) * 100 + values[index + 1]);
    index += 2;
    return value;
  }

  double readDouble(){
    return readInt().toDouble();
  }

  String readString() {
    final length = readInt();
    if (length == 0) return "";
    final start = index;
    index += length;
    return utf8.decode(values.sublist(start, start + length));
  }
}
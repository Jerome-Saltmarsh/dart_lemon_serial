
import 'dart:convert';
import 'dart:typed_data';

class ByteReader {
  var index = 0;
  late List<int> values;

  bool readBool() => readByte() == 1;

  // int readInt(){
  //   assert (index < values.length + 1);
  //   final a = readByte();
  //   return (a < 100 ? -1 : 1) * ((a % 100) * 100 + readByte());
  // }

  Uint16List readUint16List(int length){
     final values = Uint16List(length);
     for (var i = 0; i < length; i++){
       values[i] = readUInt16();
     }
     return values;
  }

  double readUDouble16() =>readUInt16().toDouble();

  int readUInt16() =>(readByte() * 256) + readByte();

  /// reads a signed integer between -127 and 127 using 2 bytes
  int readInt8(){
    final value = readUInt8();
    if (value > 127){
      return value & 0x7F;
    } else {
      return -value;
    }
  }

  /// reads a signed integer between -32768 and 32768 using 2 bytes
  int readInt16(){
    final a = readByte();
    final b = readByte();
    if (a > 127) {
      return ((a & 0x7f) << 8) + b;
    }
    return -((a << 8) + b);
  }

  double readDouble() => readInt16().toDouble();

  String readString() {
    final length = readUInt16();
    if (length == 0) return "";
    assert (index + length < values.length);
    final start = index;
    index += length;
    return utf8.decode(values.sublist(start, start + length));
  }
  
  List<int> readBytes(int length){
    assert (index + length < values.length);
    final bytes = Uint8List(length);
    for (var i = 0; i < length; i++){
      bytes[i] = readByte();
    }
    return bytes;
  }

  int readByte(){
    assert (index < values.length);
    index++;
    return values[index - 1];
  }

  int readUInt8(){
    assert (index < values.length);
    index++;
    return values[index - 1];
  }
}
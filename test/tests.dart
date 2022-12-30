import 'package:lemon_byte/byte_reader.dart';
import 'package:lemon_byte/byte_writer.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {

    var writer = ByteWriter();
    var reader = ByteReader();

    setUp(() {
      writer = ByteWriter();
      reader = ByteReader();
    });

    test('readWriteByte(0)', () {
      final value = 0;
      writer.writeByte(value);
      reader.values = writer.compile();
      expect(reader.readByte(), value);
    });

    test('readWriteByte(5)', () {
      final value = 5;
      writer.writeByte(value);
      reader.values = writer.compile();
      expect(reader.readByte(), value);
    });

    test('readWriteByte(200)', () {
      final value = 200;
      writer.writeByte(value);
      reader.values = writer.compile();
      expect(reader.readByte(), value);
    });

    test('readWriteUInt16(0)', () {
      final value = 0;
      writer.writeUInt16(value);
      reader.values = writer.compile();
      expect(reader.readUInt16(), value);
    });

    test('readWriteUInt16(100)', () {
      final value = 100;
      writer.writeUInt16(value);
      reader.values = writer.compile();
      expect(reader.readUInt16(), value);
    });

    test('readWriteUInt16(10000)', () {
      final value = 10000;
      writer.writeUInt16(value);
      reader.values = writer.compile();
      expect(reader.readUInt16(), value);
    });

    test('readWriteInt16(0)', () {
      final value = 0;
      writer.writeInt16(value);
      reader.values = writer.compile();
      expect(reader.readInt16(), value);
    });

    test('readWriteInt16(100)', () {
      final value = 100;
      writer.writeInt16(value);
      reader.values = writer.compile();
      expect(reader.readInt16(), value);
    });

    test('readWriteInt16(1000)', () {
      final value = 1000;
      writer.writeInt16(value);
      reader.values = writer.compile();
      expect(reader.readInt16(), value);
    });

    test('readWriteInt16(10000)', () {
      final value = 10000;
      writer.writeInt16(value);
      reader.values = writer.compile();
      expect(reader.readInt16(), value);
    });

    test('readInt8(0)', () {
      final value = 0;
      writer.writeInt8(value);
      reader.values = writer.compile();
      expect(reader.readInt8(), value);
    });

    test('readInt8(10)', () {
      final value = 10;
      writer.writeInt8(value);
      reader.values = writer.compile();
      expect(reader.readInt8(), value);
    });

    test('readInt8(100)', () {
      final value = 100;
      writer.writeInt8(value);
      reader.values = writer.compile();
      expect(reader.readInt8(), value);
    });

    test('readInt8(-10)', () {
      final value = -10;
      writer.writeInt8(value);
      reader.values = writer.compile();
      expect(reader.readInt8(), value);
    });

    test('readInt8(-100)', () {
      final value = -100;
      writer.writeInt8(value);
      reader.values = writer.compile();
      expect(reader.readInt8(), value);
    });

    test('readInt16(0)', () {
      final value = 0;
      writer.writeInt16(value);
      reader.values = writer.compile();
      expect(reader.readInt16(), value);
    });

    test('readInt16(100)', () {
      final value = 100;
      writer.writeInt16(value);
      reader.values = writer.compile();
      expect(reader.readInt16(), value);
    });

    test('readInt16(1000)', () {
      final value = 1000;
      writer.writeInt16(value);
      reader.values = writer.compile();
      expect(reader.readInt16(), value);
    });

    test('readInt16(10000)', () {
      final value = 10000;
      writer.writeInt16(value);
      reader.values = writer.compile();
      expect(reader.readInt16(), value);
    });

    test('readInt16(-100)', () {
      final value = -100;
      writer.writeInt16(value);
      reader.values = writer.compile();
      expect(reader.readInt16(), value);
    });

    test('readInt16(-1000)', () {
      final value = -1000;
      writer.writeInt16(value);
      reader.values = writer.compile();
      expect(reader.readInt16(), value);
    });

    test('readInt16(-10000)', () {
      final value = -10000;
      writer.writeInt16(value);
      reader.values = writer.compile();
      expect(reader.readInt16(), value);
    });
  });
}

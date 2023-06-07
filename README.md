# Binary Data Serialization in Dart

The `ByteWriter` and `ByteReader` classes are utility classes designed to facilitate reading and writing binary data in Dart. They offer a convenient way to serialize and deserialize data into byte sequences, enabling efficient storage and transmission of binary data.

## ByteWriter

The `ByteWriter` class provides methods for writing various data types into a binary format. It includes the following key methods:

- `writeBool`: Writes a boolean value to the byte buffer.
- `writeString`: Writes a string value to the byte buffer.
- `writeUint8List`: Writes a list of 8-bit unsigned integers to the byte buffer.
- `writeUint16`: Writes a 16-bit unsigned integer to the byte buffer.
- `writeBytes`: Writes a list of bytes to the byte buffer.
- ...and more.

The `compile` method returns the compiled byte sequence as a `Uint8List` that can be further processed or transmitted.

## ByteReader

The `ByteReader` class complements the `ByteWriter` class by providing methods to read data from a binary format. It maintains an internal index to keep track of the current position within the byte sequence. Key methods include:

- `readBool`: Reads a boolean value from the byte sequence.
- `readString`: Reads a string value from the byte sequence.
- `readUint8List`: Reads a list of 8-bit unsigned integers from the byte sequence.
- `readUint16`: Reads a 16-bit unsigned integer from the byte sequence.
- `readBytes`: Reads a specified number of bytes from the byte sequence.
- ...and more.

The `ByteReader` allows you to read values in the same order they were written by the `ByteWriter`.

## Usage

The `ByteWriter` and `ByteReader` classes are useful in scenarios where efficient serialization and deserialization of binary data is required. They find application in various use cases, such as:

- Working with network protocols
- Manipulating low-level binary data
- Storing binary data in a custom file format
- Efficiently transmitting binary data over a network

Please refer to the documentation within the classes for detailed information on the available methods and their usage.

## License

This project is licensed under the [MIT License](LICENSE).

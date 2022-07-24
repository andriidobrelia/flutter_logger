import 'dart:convert';
import 'dart:io';
import 'package:flutter_logger/flutter_logger.dart';

class FileOutput implements InitializedOutput {
  final File file;
  final bool overrideExisting;
  final Encoding encoding;
  late final IOSink _sink;

  FileOutput({
    required this.file,
    this.overrideExisting = false,
    this.encoding = utf8,
  });

  @override
  Future<void> init() async {
    _sink = file.openWrite(
      mode: overrideExisting ? FileMode.writeOnly : FileMode.writeOnlyAppend,
      encoding: encoding,
    );
  }

  @override
  void output(OutputEvent event) {
    _sink.writeAll(event.lines, '\n');
    _sink.writeln();
  }

  @override
  Future<void> close() async {
    await _sink.flush();
    await _sink.close();
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter_logger/flutter_logger.dart';

class ReleaseOutput extends PrinterOutput {
  @override
  void output(OutputEvent event) {
    for (var event in event.lines) {
      debugPrint(event);
    }
  }
}

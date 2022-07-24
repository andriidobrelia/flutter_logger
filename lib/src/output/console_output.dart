import 'package:flutter_logger/flutter_logger.dart';

class ConsoleOutput extends PrinterOutput {
  @override
  void output(OutputEvent event) {
    for (var event in event.lines) {
      print(event);
    }
  }
}

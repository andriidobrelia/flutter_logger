import 'package:flutter_logger/flutter_logger.dart';

abstract class PrinterOutput {
  void output(OutputEvent event);
}

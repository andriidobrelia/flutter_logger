import 'package:flutter_logger/flutter_logger.dart';

abstract class PrinterFormatter {
  List<String> print(LogEvent event);
}

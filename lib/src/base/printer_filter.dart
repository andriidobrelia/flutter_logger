import 'package:flutter_logger/flutter_logger.dart';

abstract class PrinterFilter {
  Level level = Level.information;
  String tag = '';

  bool shouldLog(FilterEvent event);
}

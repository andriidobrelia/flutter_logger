import 'package:flutter_logger/flutter_logger.dart';

abstract class BasePrinter {
  Future<void> init(PrinterBuilder builder);

  void log(String tag, String message, Level level, {Exception? error, bool isCritical = false});

  Future<void> dispose();
}

import 'package:flutter_logger/flutter_logger.dart';

abstract class InitializedOutput implements PrinterOutput {
  Future<void> init();

  Future<void> close();
}

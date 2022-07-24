import 'package:flutter_logger/flutter_logger.dart';

class OutputEvent {
  final Level level;
  final List<String> lines;

  const OutputEvent(this.level, this.lines);
}

import 'package:flutter_logger/flutter_logger.dart';

class FilterEvent {
  final Level level;
  final String tag;

  const FilterEvent(this.level, this.tag);
}
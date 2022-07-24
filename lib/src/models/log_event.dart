import 'package:flutter_logger/flutter_logger.dart';

class LogEvent {
  final Level level;
  final String tag;
  final dynamic message;
  final dynamic error;
  final Map<String, dynamic> sections;
  final bool isCritical;

  const LogEvent(this.level, this.tag, this.message, this.error, this.sections, this.isCritical);
}

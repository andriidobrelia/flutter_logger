import 'package:flutter_logger/flutter_logger.dart';

class TagFilter extends PrinterFilter {
  @override
  bool shouldLog(FilterEvent event) => event.level.index >= level.index && event.tag == tag;
}

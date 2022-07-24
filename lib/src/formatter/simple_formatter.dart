import 'dart:convert';

import 'package:flutter_logger/flutter_logger.dart';

class SimpleFormatter extends PrinterFormatter {
  static final levelPrefixes = {
    Level.information: '[I]',
    Level.warning: '[W]',
    Level.error: '[E]',
  };

  @override
  List<String> print(LogEvent event) {
    var messageStr = _stringifyMessage(event.message);
    var errorStr = event.error != null ? 'ERROR: ${event.error}' : '';
    var sectionsStr = _stringifyMessage(event.sections);
    return ['${levelPrefixes[event.level]} $messageStr $sectionsStr $errorStr'];
  }

  String _stringifyMessage(dynamic message) {
    final finalMessage = message is Function ? message() : message;
    if (finalMessage is Map || finalMessage is Iterable) {
      var encoder = const JsonEncoder();
      return encoder.convert(finalMessage);
    } else {
      return finalMessage.toString();
    }
  }
}

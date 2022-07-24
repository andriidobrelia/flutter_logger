import 'dart:convert';

import 'package:flutter_logger/flutter_logger.dart';

class ColoredPrinter extends PrinterFormatter {
  static final levelPrefixes = {
    Level.information: '[I]',
    Level.warning: '[W]',
    Level.error: '[E]',
  };

  static final colorsLevel = {
    Level.information: AnsiColor.fg(12),
    Level.warning: AnsiColor.fg(208),
    Level.error: AnsiColor.fg(196),
  };

  final bool withTime;
  final bool isColored;

  ColoredPrinter({this.withTime = false, this.isColored = true});

  @override
  List<String> print(LogEvent event) {
    var messageStr = _stringifyMessage(event.message);
    var errorStr = event.error != null ? '  ERROR: ${event.error}' : '';
    var timeStr = withTime ? 'TIME: ${DateTime.now().toIso8601String()}' : '';
    return ['${_coloredMessage(event.level)} $timeStr $messageStr$errorStr'];
  }

  String _coloredMessage(Level level) {
    var prefix = levelPrefixes[level]!;
    var color = colorsLevel[level]!;

    return isColored ? color(prefix) : prefix;
  }

  String _stringifyMessage(dynamic message) {
    final finalMessage = message is Function ? message() : message;
    if (finalMessage is Map || finalMessage is Iterable) {
      var encoder = const JsonEncoder.withIndent('');
      return encoder.convert(finalMessage);
    } else {
      return finalMessage.toString();
    }
  }
}

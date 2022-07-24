library flutter_logger;

import 'package:flutter_logger/flutter_logger.dart';

enum Level {
  information,
  warning,
  error;

  String get capitalizedName => name[0].toUpperCase() + name.substring(1);
}

/// A Calculator.
class FlutterLogger {
  static final _modes = <Type, BasePrinter>{};

  static void i(String msg, [String tag = '', Exception? error]) =>
      _operateMode((mode) => mode.log(tag, msg, Level.information, error: error, isCritical: false));

  static void w(String msg, [String tag = '', Exception? error, bool isCritical = false]) =>
      _operateMode((mode) => mode.log(tag, msg, Level.warning, error: error, isCritical: isCritical));

  static void e(String msg, [String tag = '', Exception? error, bool isCritical = false]) =>
      _operateMode((mode) => mode.log(tag, msg, Level.error, error: error, isCritical: isCritical));

  static void addMode(Printer mode) => _modes[mode.runtimeType] = mode;

  static void removeMode(Printer mode) => _modes.remove(mode.runtimeType);

  static void removeAllModes() => _modes.clear();

  static void _operateMode(Function(BasePrinter) action) => _modes.values.forEach(action);
}

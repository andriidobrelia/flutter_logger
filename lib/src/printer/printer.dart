import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_logger/flutter_logger.dart';

class Printer implements BasePrinter {
  final PrinterOutput _output;
  final PrinterFilter _filter;
  final PrinterFormatter _formatter;
  final List<PrinterSection> _sections;
  final _initCompleter = Completer<void>();

  Printer.builder(PrinterBuilder builder)
      : _output = builder.output ?? ConsoleOutput(),
        _filter = builder.filter ?? TagFilter(),
        _formatter = builder.formatter ?? SimpleFormatter(),
        _sections = builder.sections {
      init(builder);
  }

  @override
  Future<void> init(PrinterBuilder builder) async {
    _filter.level = builder.level ?? Level.information;
    _filter.tag = builder.tag;
    if (_output is InitializedOutput) {
      (_output as FileOutput).init();
    }
    await Future.wait([
      for (var section in _sections) section.init(),
    ]);
    _initCompleter.complete();
  }

  @override
  void log(String tag, String message, Level level, {Exception? error, bool isCritical = false}) async {
    if (!_initCompleter.isCompleted) await _initCompleter.future;
    var filterEvent = FilterEvent(level, tag);
    if (_filter.shouldLog(filterEvent)) {
      final sectionList = [for (var section in _sections) section.assemble()];

      final additionalInfo = {for (var map in sectionList) ...map};

      var logEvent = LogEvent(level, tag, message, error, additionalInfo, isCritical);
      var output = _formatter.print(logEvent);

      if (output.isNotEmpty) {
        var outputEvent = OutputEvent(level, output);

        try {
          _output.output(outputEvent);
        } catch (error, stackTrace) {
          debugPrint('Error: $error\n StackTrace: $stackTrace');
        }
      }
    }
  }

  @override
  Future<void> dispose() async {
    if (_output is InitializedOutput) {
      (_output as FileOutput).close();
    }
  }
}

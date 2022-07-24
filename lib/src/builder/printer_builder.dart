import 'package:flutter_logger/flutter_logger.dart';

class PrinterBuilder {
  //todo add functionality
  final List<PrinterSection> sections = []; // todo maybe we need use a Map
  PrinterOutput? output;
  PrinterFilter? filter;
  PrinterFormatter? formatter;
  Level? level;
  String tag;

  PrinterBuilder({this.output, this.formatter, this.filter, this.tag = ''});

  Printer build() => Printer.builder(this);

  // todo create method where we can dispose Section and delete it from collection

  addSection(PrinterSection section) => sections.add(section);

  setLevel(Level level) => this.level = level;
}

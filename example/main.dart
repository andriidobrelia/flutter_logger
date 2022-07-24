import 'package:flutter_logger/flutter_logger.dart';

void main() {
  demo();
}

void demo() async {
  final builder = PrinterBuilder(filter: TagFilter(), tag: 'stage');
  FlutterLogger.addMode(builder.build());
  FlutterLogger.i("test1", "stage");
  FlutterLogger.w("test2", "stage");
  FlutterLogger.e("test3");
}

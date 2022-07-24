import 'package:battery_plus/battery_plus.dart';
import 'package:flutter_logger/flutter_logger.dart';

class BatterySection extends PrinterSection {
  final Battery _battery = Battery();
  late final List<dynamic> batteryInfo;
  static const _batteryLevelKey = 'batteryLevel';
  static const _batteryStateKey = 'batteryState';
  static const _isSaveModeKey = 'isSaveMode';

  @override
  Future<void> init() async => batteryInfo = await Future.wait(<Future>[
      _battery.batteryLevel,
      _battery.batteryState,
      _battery.isInBatterySaveMode,
    ]);

  @override
  Map<String, dynamic> assemble() {
    final batteryLevel = batteryInfo[0];
    final batteryState = batteryInfo[1] as BatteryState;
    final isSaveMode = batteryInfo[2];
    return {
      _batteryLevelKey: batteryLevel,
      _batteryStateKey: batteryState.name,
      _isSaveModeKey: isSaveMode,
    };
  }
}

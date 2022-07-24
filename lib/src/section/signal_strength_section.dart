import 'package:flutter_logger/flutter_logger.dart';
import 'package:signal_strength/models/signal_model.dart';
import 'package:signal_strength/signal_strength.dart';

class SignalStrengthSection extends PrinterSection {
  final SignalStrength _signalStrength = SignalStrength();
  late final Signal? _signalInfo;
  static const _networkTypeKey = 'networkType';
  static const _carrierKey = 'Carrier';
  static const _wifiStrengthKey = 'Wifi Strength';
  static const _networkStrengthKey = 'Network Strength';

  @override
  Future<void> init() async => _signalInfo = await _signalStrength.getSignalStrength();

  @override
  Map<String, dynamic> assemble() {
    final connectionType = _signalInfo?.type as ConnectionType;
    return {
      _networkTypeKey: connectionType.name,
      _carrierKey: _signalInfo?.carrier,
      _wifiStrengthKey: _signalInfo?.wifiInfoFormatted,
      _networkStrengthKey: _signalInfo?.cellularInfoFormatted,
    };
  }
}

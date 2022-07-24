import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter_logger/flutter_logger.dart';

class DeviceInfoSection implements PrinterSection {
  static const _sourceKey = 'Source';
  static const _operatingSystemKey = 'OS';
  static const _operationSystemVersionKey = 'OS Version';
  static const _phoneModelKey = 'Model';
  static const _manufacturerKey = 'Manufacturer';

  static const _sourceAppAndroidValue = 'Android - App';
  static const _sourceAppIOSValue = 'IOS - App';

  late final String _osVersion;
  late final String _manufacturer;
  late final String _model;
  late final String _platform;

  @override
  Future<void> init() async {
    if (Platform.isAndroid) {
      _platform = Platform.operatingSystem;
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      _manufacturer = androidInfo.manufacturer;
      _model = androidInfo.model;
      _osVersion = androidInfo.version.release;
    }

    if (Platform.isIOS) {
      _platform = Platform.operatingSystem;
      const appleManufacturer = 'Apple';
      final iosInfo = await DeviceInfoPlugin().iosInfo;
      _manufacturer = appleManufacturer;
      _model = iosInfo.utsname.machine;
      _osVersion = iosInfo.systemVersion;
    }
  }

  @override
  Map<String, dynamic> assemble() {
    return {
      _sourceKey: _platform == 'ios' ? _sourceAppIOSValue : _sourceAppAndroidValue,
      _operatingSystemKey: _platform,
      _operationSystemVersionKey: _osVersion,
      _phoneModelKey: _model,
      _manufacturerKey: _manufacturer,
    };
  }
}

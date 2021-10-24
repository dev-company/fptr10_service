import 'dart:async';

import 'package:flutter/services.dart';

class Fptr10Service {
  static const MethodChannel _channel =
      MethodChannel('company.dev/fptr10_service');

  static Future<String?> get driverVersion async {
    final String? version = await _channel.invokeMethod('getDriverVersion');
    return version;
  }

  //   static Future<String?> get platformVersion async {
  //   final String? version = await _channel.invokeMethod('getPlatformVersion');
  //   return version;
  // }
}

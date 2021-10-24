import 'dart:async';
import 'package:flutter/services.dart';

class Fptr10Service {
  static const String CLOSE = 'close';
  static const String DRIVER_VERSION = 'getDriverVersion';
  static const String IS_OPENED = 'isOpened';
  static const String OPEN = 'open';

  static const MethodChannel _channel =
      MethodChannel('company.dev/fptr10_service');

  static Future<String?> get driverVersion async =>
      await _channel.invokeMethod('getDriverVersion');
  static Future<void> close() async => await _channel.invokeMethod(CLOSE);
  static Future<void> open() async => await _channel.invokeMethod(OPEN);
  static Future<void> isOpened() async =>
      await _channel.invokeMethod(IS_OPENED);

  static Future<String?> get settings async {
    final String? settings = await _channel.invokeMethod('getSettings');
    return settings;
  }

  static Future<bool> setupSettings(String? ip, int? port) async {
    bool success = false;
    try {
      await _channel.invokeMethod('setSettings', <String, dynamic>{
        'tcp_ip_address': ip ?? '192.168.1.10',
        'tcp_ip_port': port ?? 5555,
      });
      success = true;
    } on PlatformException {}
    return success;
  }
}

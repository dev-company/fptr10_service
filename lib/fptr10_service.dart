
import 'dart:async';

import 'package:flutter/services.dart';

class Fptr10Service {
  static const MethodChannel _channel = MethodChannel('fptr10_service');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}

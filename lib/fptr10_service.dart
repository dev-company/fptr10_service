// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'data/status/fptr_status.dart';

class Fptr10Service {
  static const String CLOSE = 'close';
  static const String DRIVER_VERSION = 'getDriverVersion';
  static const String IS_OPENED = 'isOpened';
  static const String OPEN = 'open';

  static const MethodChannel channel =
      MethodChannel('company.dev/fptr10_service');

  static Future<String?> get driverVersion async =>
      await channel.invokeMethod('getDriverVersion');

  static Future<FptrStatus> get status async => await channel
      .invokeMethod('getStatus')
      .then((value) => FptrStatus.fromEvent(Map<String, dynamic>.from(value)));

  static Future<bool> close() async => await channel
      .invokeMethod<bool>(CLOSE)
      .then<bool>((bool? value) => value ?? false);

  static Future<bool> open() async => await channel
      .invokeMethod<bool>(OPEN)
      .then<bool>((bool? value) => value ?? false);

  static Future<bool> isOpened() async => await channel
      .invokeMethod<bool>(IS_OPENED)
      .then<bool>((bool? value) => value ?? false);

  static Future<String?> get settings async {
    final String? settings = await channel.invokeMethod('getSettings');
    return settings;
  }

  static Future<void> setupSettings(String ip, int? port) async {
    try {
      await channel.invokeMethod('setSettings', <String, dynamic>{
        'tcp_ip_address': ip,
        'tcp_ip_port': port ?? 5555,
      });
    } on PlatformException {
      debugPrint('an error');
    }
  }

  // event
  static const EventChannel statusChannel =
      EventChannel('company.dev/fptr10_events/status');

  static Stream<dynamic>? _onFptrStatusChanged;
  static Stream<dynamic> onFptrStatusChanged() {
    _onFptrStatusChanged ??= statusChannel
        .receiveBroadcastStream()
        .map((event) => _parseStatus(event));
    return _onFptrStatusChanged!;
  }

  static dynamic _parseStatus(dynamic state) {
    debugPrint(state.toString());

    return state.toString();
  }
}

class Fptr10ServiceTasks extends Fptr10Service {
  static const String PERFORM_JSON = 'performJson';

  static Future<void> sendTask(Map<String, dynamic> task) async {
    final String taskString = json.encode(task).toString();

    String result = await Fptr10Service.channel
        .invokeMethod(PERFORM_JSON, {'task': taskString});

    debugPrint(result);
  }

  static Future<String> sendTaskWithResponse(Map<String, dynamic> task) async {
    final String taskString = json.encode(task).toString();

    String result = await Fptr10Service.channel
        .invokeMethod(PERFORM_JSON, {'task': taskString});

    return result;
  }
}

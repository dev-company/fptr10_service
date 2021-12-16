// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'fptr10_service.dart';

class Fptr10ServiceTasks extends Fptr10Service {
  static const String PERFORM_JSON = 'performJson';

  static Future<void> sendTask(Map<String, dynamic> task) async {
    try {
      final String taskString = json.encode(task);

      String result = await Fptr10Service.channel.invokeMethod(PERFORM_JSON, {'task': taskString});

      debugPrint(result);
    } on PlatformException catch (e) {
      throw Fptr10Exception(e.code, e.message);
    }
  }

  static Future<String> sendTaskWithResponse(Map<String, dynamic> task) async {
    final String taskString = json.encode(task).toString();
    try {
      String result = await Fptr10Service.channel.invokeMethod(PERFORM_JSON, {'task': taskString});

      return result;
    } on PlatformException catch (e) {
      throw Fptr10Exception(e.code, e.message);
    }
  }

  static Future<dynamic> sendTaskWithParsedResponse(Map<String, dynamic> task) async {
    final String taskString = json.encode(task).toString();
    try {
      dynamic resultString = await Fptr10Service.channel.invokeMethod(PERFORM_JSON, {'task': taskString});

      dynamic result = json.decode(resultString);

      return result;
    } on PlatformException catch (e) {
      throw Fptr10Exception(e.code, e.message);
    }
  }
}

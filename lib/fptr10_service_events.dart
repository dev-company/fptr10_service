import 'dart:async';
import 'package:flutter/services.dart';

class Fptr10ServiceEvents {
  final _statusEventChannel =
      const EventChannel('company.dev/fptr10_service/events/status');
}

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fptr10_service/fptr10_service.dart';

void main() {
  const MethodChannel channel = MethodChannel('company.dev/fptr10_service');

  // TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '10.9.0.5';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getDriverVersion', () async {
    expect(await Fptr10Service.driverVersion, '10.9.0.5');
  });
}

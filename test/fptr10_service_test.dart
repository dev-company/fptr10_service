import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fptr10_service/fptr10_service.dart';

void main() {
  const MethodChannel channel = MethodChannel('fptr10_service');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await Fptr10Service.platformVersion, '42');
  });
}

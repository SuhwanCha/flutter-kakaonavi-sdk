import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kakaonavi/kakaonavi_method_channel.dart';

void main() {
  MethodChannelKakaonavi platform = MethodChannelKakaonavi();
  const MethodChannel channel = MethodChannel('kakaonavi');

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
    expect(await platform.getPlatformVersion(), '42');
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:kakaonavi/kakaonavi.dart';
import 'package:kakaonavi/kakaonavi_platform_interface.dart';
import 'package:kakaonavi/kakaonavi_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockKakaonaviPlatform
    with MockPlatformInterfaceMixin
    implements KakaonaviPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final KakaonaviPlatform initialPlatform = KakaonaviPlatform.instance;

  test('$MethodChannelKakaonavi is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelKakaonavi>());
  });

  test('getPlatformVersion', () async {
    Kakaonavi kakaonaviPlugin = Kakaonavi();
    MockKakaonaviPlatform fakePlatform = MockKakaonaviPlatform();
    KakaonaviPlatform.instance = fakePlatform;

    expect(await kakaonaviPlugin.getPlatformVersion(), '42');
  });
}

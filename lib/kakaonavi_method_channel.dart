part of kakao_navi;

/// An implementation of [KakaonaviPlatform] that uses method channels.
class MethodChannelKakaonavi extends KakaonaviPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('kakaonavi');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}

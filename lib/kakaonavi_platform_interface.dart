import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'kakaonavi_method_channel.dart';

abstract class KakaonaviPlatform extends PlatformInterface {
  /// Constructs a KakaonaviPlatform.
  KakaonaviPlatform() : super(token: _token);

  static final Object _token = Object();

  static KakaonaviPlatform _instance = MethodChannelKakaonavi();

  /// The default instance of [KakaonaviPlatform] to use.
  ///
  /// Defaults to [MethodChannelKakaonavi].
  static KakaonaviPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [KakaonaviPlatform] when
  /// they register themselves.
  static set instance(KakaonaviPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}

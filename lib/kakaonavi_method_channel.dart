import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'kakaonavi_platform_interface.dart';

/// An implementation of [KakaonaviPlatform] that uses method channels.
class MethodChannelKakaonavi extends KakaonaviPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('kakaonavi');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}

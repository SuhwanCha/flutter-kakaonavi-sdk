
import 'kakaonavi_platform_interface.dart';

class Kakaonavi {
  Future<String?> getPlatformVersion() {
    return KakaonaviPlatform.instance.getPlatformVersion();
  }
}

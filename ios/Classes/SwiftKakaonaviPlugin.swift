import Flutter
import UIKit

public class SwiftKakaonaviPlugin: NSObject, FlutterPlugin {
  var registrar: FlutterPluginRegistrar?

  public static func register(with registrar: FlutterPluginRegistrar) {

      KNSDK.sharedInstance()!.initialize(withAppKey: "818c9527e5c9aaf2c451c48367315e16", clientVersion: "1.6.5", langType: KNLanguageType.ENGLISH, mapType: KNMapType.fullMap) {
          error in
          if let error {
              print("KNSDK Init Failed(\(String(describing: error.code)), \(String(describing: error.msg)))")
          } else {
            // emit toflutter

              print("설정 완료")
          }
      }

    let kakaonaviFactory = KakaonaviFactory(registrar: registrar)
    registrar.register(kakaonaviFactory, withId: "plugins.flutter.io/kakaonavi")
  }
}

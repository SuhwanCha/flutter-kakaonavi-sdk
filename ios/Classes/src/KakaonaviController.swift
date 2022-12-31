import UIKit
import Flutter
import CoreLocation



class KakaonaviController: NSObject, FlutterPlatformView,KNNaviView_GuideStateDelegate,
                          KNGuidance_LocationGuideDelegate, KNNaviView_StateDelegate{
    func naviViewDidUpdateSndVolume(_ aVolume: Float) {
        
    }
    
    func naviViewDidUpdateUseDarkMode(_ aDarkMode: Bool) {
        
    }
    
    func naviViewDidUpdateMapCameraMode(_ aMapViewCameraMode: MapViewCameraMode) {
        
    }
    
    func guidance(_ aGuidance: KNGuidance, didUpdate aLocationGuide: KNGuide_Location) {
    }
    
    func naviViewGuideEnded(_ aNaviView: KNNaviView) {
        print("naviViewGuideEnded")
        print(aNaviView)
    }
    
    func naviViewGuideState(_ aGuideState: KNGuideState) {
        print("naviViewGuideState")
        print(aGuideState)
    }
    
    
    let viewId : Int64
    var channel : FlutterMethodChannel?
    var registrar : FlutterPluginRegistrar?
    var naviView: KNNaviView

    init(viewId: Int64, frame: CGRect, registrar: FlutterPluginRegistrar, argument: NSDictionary?) {
      self.viewId = viewId
      self.registrar = registrar
      let guidance = KNSDK.sharedInstance()!.sharedGuidance()
      self.naviView = KNNaviView(guidance: guidance, trip: nil, routeOption: KNRoutePriority.recommand, avoidOption: KNRouteAvoidOption.none)
      self.channel = FlutterMethodChannel(name: "plugins.flutter.io/kakaonavi_\(viewId)", binaryMessenger: registrar.messenger())

      super.init()


      let start = KNPOI.init(name: "집", x: 290122, y: 564488, address: "경기도 파주시 교하로 70")
      // 목적지 설정
      let goal = KNPOI.init(name: "회사", x: 316554, y: 545039, address: "서울특별시 강남구 압구정로36길 55")
      
      // 경로 생성
      KNSDK.sharedInstance()!.makeTrip(withStart: start, goal: goal, vias: nil) { aError, aTrip in
          if aError != nil {
              print("경로 생성 실패")
              print("KNSDK Init Failed(\(String(describing: aError?.code)), \(String(describing: aError?.msg)))")
          } else {
              guidance.start(with: aTrip!, priority: KNRoutePriority.recommand, avoidOptions: 0)
              print("경로 생성 성공")

          }
      }
            
      guidance.locationGuideDelegate = self
      naviView.guideStateDelegate = self
      naviView.stateDelegate = self
      naviView.sndVolume(0)
      
    channel?.setMethodCallHandler({
      [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
      guard let self = self else {
        return
      }
      self.handle(call: call, result: result)
    })
      
    
  }

  func handle(call: FlutterMethodCall, result: FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  func view() -> UIView {
      let guidance = KNSDK.sharedInstance()!.sharedGuidance()
    
      KNSDK.sharedInstance()!.sharedGpsManager().backgroundUpdateType = KNGPSBackgroundUpdateType.always
      guidance.startWithoutTrip()
      naviView.useDarkMode(true)


    return naviView
  }
}

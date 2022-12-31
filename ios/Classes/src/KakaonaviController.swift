import UIKit
import Flutter
import CoreLocation



class KakaonaviController: NSObject, FlutterPlatformView,KNNaviView_GuideStateDelegate,
                           KNGuidance_LocationGuideDelegate, KNNaviView_StateDelegate, KNGuidance_GuideStateDelegate, KNGuidance_RouteGuideDelegate, KNGuidance_VoiceGuideDelegate,  KNGuidance_SafetyGuideDelegate, KNGuidance_CitsGuideDelegate {
    func guidance(_ aGuidance: KNGuidance, didUpdateSafetyGuide aSafetyGuide: KNGuide_Safety) {
        print("guidance")
    }
    
    func guidance(_ aGuidance: KNGuidance, didUpdateAroundSafeties aSafeties: [KNSafety]?) {
        print("guidance")
    }
    
    func guidance(_ aGuidance: KNGuidance, didUpdateCitsGuide aCitsGuide: KNGuide_Cits) {
        print("guidance")
    }
    
    
    func guidance(_ aGuidance: KNGuidance, shouldPlayVoiceGuide aVoiceGuide: KNGuide_Voice, replaceSndData aNewData: AutoreleasingUnsafeMutablePointer<NSData?>!) -> Bool {
        print("guidance")
        
        return true
    }
    
    func guidance(_ aGuidance: KNGuidance, willPlayVoiceGuide aVoiceGuide: KNGuide_Voice) {
        print(aVoiceGuide)
    }
    
    func guidance(_ aGuidance: KNGuidance, didFinishPlayVoiceGuide aVoiceGuide: KNGuide_Voice) {
        print("guidance")
    }
    
    func guidance(_ aGuidance: KNGuidance, didUpdateRouteGuide aRouteGuide: KNGuide_Route) {
        print("guidance")
    }
    
    func guidanceGuideStarted(_ aGuidance: KNGuidance) {
        print("guidanceGuideStarted")
    }
    
    func guidanceCheckingRouteChange(_ aGuidance: KNGuidance) {
        print("guidanceCheckingRouteChange")
    }
    
    func guidanceOut(ofRoute aGuidance: KNGuidance) {
        print("guidanceOut")
    }
    
    func guidanceRouteUnchanged(_ aGuidance: KNGuidance) {
        print("guidanceRouteUnchanged")
    }
    
    func guidance(_ aGuidance: KNGuidance, routeUnchangedWithError aError: KNError) {
        print("guidance")
    }
    
    func guidanceRouteChanged(_ aGuidance: KNGuidance) {
        print("guidanceRouteChanged")
    }
    
    func guidanceGuideEnded(_ aGuidance: KNGuidance) {
        print("guidanceGuideEnded")
    }
    
    func guidance(_ aGuidance: KNGuidance, didUpdate aRoutes: [KNRoute], multiRouteInfo aMultiRouteInfo: KNMultiRouteInfo?) {
        print("guidance")
    }
    
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
    private var _view: UIView
    var channel : FlutterMethodChannel?
    var registrar : FlutterPluginRegistrar?
    var sdk : KNSDK

    init(viewId: Int64, frame: CGRect, registrar: FlutterPluginRegistrar, argument: NSDictionary?) {
      self.viewId = viewId

      self.registrar = registrar
        
        self.sdk = KNSDK.sharedInstance()!
      let guidance = sdk.sharedGuidance()
      self.channel = FlutterMethodChannel(name: "plugins.flutter.io/kakaonavi_\(viewId)", binaryMessenger: registrar.messenger())
        _view = UIView()
        
        let naviView = KNNaviView(guidance: guidance, trip: nil, routeOption: KNRoutePriority.recommand, avoidOption: KNRouteAvoidOption.none)
        
        _view.addSubview(naviView)

      super.init()
        
        guidance.guideStateDelegate = self;
        guidance.routeGuideDelegate = self;
        guidance.voiceGuideDelegate = self;
        guidance.safetyGuideDelegate = self;
        guidance.locationGuideDelegate = self;
        guidance.citsGuideDelegate = self;
        guidance.useBackgroundUpdate = true
        KNSDK.sharedInstance()!.sharedGpsManager().backgroundUpdateType = KNGPSBackgroundUpdateType.always
      
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
    case "startGuide":
//        call.arguments
      startGuide()
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  func view() -> UIView {
    return _view
  }

  func startGuide() {

      let mapPos = KNSDK.sharedInstance()!.convertWGS84ToKATEC(withLongitude: 126.73034595190879, latitude: 37.7280661381458)
      
      let start = KNPOI.init(name: "집", x: mapPos.x, y: mapPos.y)
    // 목적지 설정
      
      let goalPos = KNSDK.sharedInstance()!.convertWGS84ToKATEC(withLongitude: 127.04343256908045, latitude: 37.517515648008455)
      let goal = KNPOI.init(name: "회사", x: goalPos.x, y: goalPos.y)
      
//      KNSDK.sharedInstance()!.makeTrip(withStart: <#T##KNPOI#>, goal: <#T##KNPOI#>, vias: <#T##[KNPOI]?#>, completion: <#T##(KNError?, KNTrip?) -> Void#>)
      self.sdk.makeTrip(withStart: start, goal: goal, vias: []) { aError, aTrip in
          if aError != nil {
              print("경로 찾기 실패")
          } else {
              let guidance = self.sdk.sharedGuidance()
              let routeConfig = KNRouteConfiguration(carType: KNCarType._2, fuel: KNCarFuel.gasoline, useHipass: true, usage: KNCarUsage.default)
              aTrip!.routeConfig = routeConfig
              let naviView = KNNaviView(guidance: guidance, trip: aTrip, routeOption: KNRoutePriority.recommand, avoidOption: KNRouteAvoidOption.none)
              naviView.frame = UIScreen.main.bounds
              naviView.guideStateDelegate = self;
              naviView.stateDelegate = self;
              
              self._view.addSubview(naviView)
              naviView.useDarkMode(true)
          }
      }
  }
}

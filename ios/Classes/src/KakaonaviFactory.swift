import Flutter

class KakaonaviFactory: NSObject, FlutterPlatformViewFactory {

    let refistrar : FlutterPluginRegistrar    
  
    init(registrar: FlutterPluginRegistrar) {
        self.refistrar = registrar
    }

    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return KakaonaviController(viewId: viewId, frame: frame, registrar: refistrar, argument: args as? NSDictionary)
    }

    func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }

}

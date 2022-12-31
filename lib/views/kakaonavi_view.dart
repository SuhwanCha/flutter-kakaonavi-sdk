part of kakao_navi;

class KakaonaviView extends StatefulWidget {
  const KakaonaviView({super.key});

  @override
  State<KakaonaviView> createState() => _KakaonaviViewState();
}

class _KakaonaviViewState extends State<KakaonaviView> {
  late final MethodChannel _channel;

  @override
  Widget build(BuildContext context) {
    return UiKitView(
      viewType: 'plugins.flutter.io/kakaonavi',
      creationParams: const <String, dynamic>{},
      onPlatformViewCreated: onPlatformViewCreated,
      creationParamsCodec: const StandardMessageCodec(),
    );
  }

  void onPlatformViewCreated(int id) async {
    _channel = MethodChannel('plugins.flutter.io/kakaonavi_$id');
    try {
      final String platformVersion =
          await _channel.invokeMethod('getPlatformVersion');
      print(platformVersion);
    } on PlatformException catch (e) {
      print(e);
    }
  }
}

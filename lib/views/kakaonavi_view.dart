part of kakao_navi;

class KakaonaviView extends StatefulWidget {
  const KakaonaviView({
    super.key,
    this.bloc,
  });

  final NaviBloc? bloc;

  @override
  State<KakaonaviView> createState() => _KakaonaviViewState();
}

class _KakaonaviViewState extends State<KakaonaviView> {
  late final MethodChannel _channel;

  @override
  Widget build(BuildContext context) {
    return widget.bloc == null
        ? BlocProvider<NaviBloc>(
            create: (context) => NaviBloc(),
            child: const KakaoNaviBuilder(),
          )
        : BlocProvider.value(
            value: widget.bloc!,
            child: const KakaoNaviBuilder(),
          );
  }
}

class KakaoNaviBuilder extends StatelessWidget {
  const KakaoNaviBuilder({super.key});

  void onPlatformViewCreated(int id, BuildContext context) async {
    final channel = MethodChannel('plugins.flutter.io/kakaonavi_$id');
    context.read<NaviBloc>().add(NaviInitialized(channel: channel));
    // try {
    //   final String platformVersion =
    //       await _channel.invokeMethod('getPlatformVersion');
    //   print(platformVersion);
    // } on PlatformException catch (e) {
    //   print(e);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return UiKitView(
      viewType: 'plugins.flutter.io/kakaonavi',
      creationParams: const <String, dynamic>{},
      onPlatformViewCreated: (id) => onPlatformViewCreated(id, context),
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
}

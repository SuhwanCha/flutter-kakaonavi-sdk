part of kakao_navi;

class KakaonaviView extends StatefulWidget {
  const KakaonaviView({
    super.key,
    this.onLocationUpdate,
    this.bloc,
  });

  final NaviBloc? bloc;

  final void Function(LocationUpdate location)? onLocationUpdate;

  @override
  State<KakaonaviView> createState() => _KakaonaviViewState();
}

class _KakaonaviViewState extends State<KakaonaviView> {
  @override
  Widget build(BuildContext context) {
    return widget.bloc == null
        ? BlocProvider<NaviBloc>(
            create: (context) => NaviBloc(),
            child: KakaoNaviBuilder(
              onLocationUpdate: widget.onLocationUpdate,
            ),
          )
        : BlocProvider.value(
            value: widget.bloc!,
            child: KakaoNaviBuilder(
              onLocationUpdate: widget.onLocationUpdate,
            ),
          );
  }
}

class KakaoNaviBuilder extends StatelessWidget {
  const KakaoNaviBuilder({super.key, this.onLocationUpdate});

  final Function(LocationUpdate)? onLocationUpdate;

  void onPlatformViewCreated(int id, BuildContext context) async {
    final channel = MethodChannel('plugins.flutter.io/kakaonavi_$id');
    channel.setMethodCallHandler(_handleMethodCall);
    context.read<NaviBloc>().add(NaviInitialized(channel: channel));
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

  Future<dynamic> _handleMethodCall(MethodCall call) {
    print(call.method);
    print(call.arguments);
    switch (call.method) {
      case 'guide#update':
        final locationUpdate =
            LocationUpdate.fromJson(call.arguments as Map<Object?, Object?>);
        print(locationUpdate);
        if (onLocationUpdate != null) {
          onLocationUpdate!(locationUpdate);
        }
        break;
      default:
        throw MissingPluginException();
    }
    return Future<dynamic>.value();
  }
}

part of kakao_navi;

@immutable
abstract class NaviEvent {}

class NaviInitialized extends NaviEvent {
  final MethodChannel channel;

  NaviInitialized({required this.channel});
}

class NaviGuideStarted extends NaviEvent {
  final String name;
  final double lat;
  final double lng;
  final String address;

  final double startLat;
  final double startLng;

  NaviGuideStarted({
    required this.name,
    required this.lat,
    required this.lng,
    required this.address,
    required this.startLat,
    required this.startLng,
  });
}

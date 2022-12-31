part of kakao_navi;

class LocationUpdate {
  final int remainTime;
  final int remainDistance;

  LocationUpdate({
    required this.remainTime,
    required this.remainDistance,
  });

  Map<String, dynamic> toJson() {
    return {
      'remainTime': remainTime,
      'remainDistance': remainDistance,
    };
  }

  factory LocationUpdate.fromJson(Map<Object?, Object?> json) {
    return LocationUpdate(
      remainTime: json['remainTime'] as int,
      remainDistance: json['remainDistance'] as int,
    );
  }
}

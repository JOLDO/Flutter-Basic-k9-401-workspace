class EarthquakeInfo {
  final String originTime;
  final double magnitude;
  final String location;
  final double depth;

  EarthquakeInfo({
    required this.originTime,
    required this.magnitude,
    required this.location,
    required this.depth,
  });

  factory EarthquakeInfo.fromJson(Map<String, dynamic> json) {
    return EarthquakeInfo(
      originTime: json['originTime']?.toString() ?? '',
      magnitude: double.tryParse(json['magnitude']?.toString() ?? '0') ?? 0.0,
      location: json['location']?.toString() ?? '',
      depth: double.tryParse(json['depth']?.toString() ?? '0') ?? 0.0,
    );
  }
}
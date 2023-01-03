class Location {
  final double latitude;
  final double longitude;
  Location({
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      latitude: map['lat']?.toDouble() ?? 0.0,
      longitude: map['lng']?.toDouble() ?? 0.0,
    );
  }
}

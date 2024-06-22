class BusStops {
  final String name;
  final int styleUrl;
  final double latitude;
  final double longitude;
  final String ward;

  BusStops(this.name, this.styleUrl, this.latitude, this.longitude, this.ward);

  factory BusStops.fromJson(Map<String, dynamic> json) {
    return BusStops(
      json['name'],
      json['styleUrl'],
      json['latitude'],
      json['longitude'],
      json['ward'],
    );
  }
}

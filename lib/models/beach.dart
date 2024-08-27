// lib/models/beach.dart

class Beach {
  final String name;
  final String location;
  final String description;
  final double latitude; // Ensure these properties are defined
  final double longitude;

  Beach({
    required this.name,
    required this.location,
    required this.description,
    required this.latitude,
    required this.longitude,
  });

  factory Beach.fromJson(Map<String, dynamic> json) {
    return Beach(
      name: json['name'],
      location: json['location'],
      description: json['description'] ?? '',
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
    );
  }
}

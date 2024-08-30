// import 'package:coastal_tourism_app/services/location_service.dart';
//
// class Beach {
//   final String name;
//   final double latitude;
//   final double longitude;
//   double distance;
//
//   Beach({required this.name, required this.latitude, required this.longitude, this.distance = 0});
// }
//
// class BeachService {
//   final LocationService _locationService = LocationService();
//
//   Future<List<Beach>> getNearbyBeaches(double maxDistance) async {
//     final userLocation = await _locationService.getCurrentLocation();
//     final allBeaches = await fetchAllBeaches();
//
//     return allBeaches.where((beach) {
//       final distanceInMeters = _locationService.calculateDistance(
//         userLocation.latitude,
//         userLocation.longitude,
//         beach.latitude,
//         beach.longitude,
//       );
//       beach.distance = distanceInMeters / 1000; // Convert to kilometers
//       return distanceInMeters <= maxDistance;
//     }).toList();
//   }
//
//   Future<List<Beach>> fetchAllBeaches() async {
//     // TODO: Implement this method to fetch beaches from your data source
//     // This is a placeholder implementation
//     return [
//       Beach(name: 'Beach 1', latitude: 40.7128, longitude: -74.0060),
//       Beach(name: 'Beach 2', latitude: 34.0522, longitude: -118.2437),
//       Beach(name: 'Beach 3', latitude: 51.5074, longitude: -0.1278),
//     ];
//   }
// }

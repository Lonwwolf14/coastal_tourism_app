// import 'package:geolocator/geolocator.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
// import '../config/config.dart';
//
// class LocationService {
//   static const String _locationKey = 'user_location';
//
//   Future<Position> getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return Future.error('Location services are disabled.');
//     }
//
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       return Future.error('Location permissions are permanently denied, we cannot request permissions.');
//     }
//
//     if (Config.useMockData) {
//       // Return a mock location for testing
//       return Position(
//         latitude: 12.9716,
//         longitude: 77.5946,
//         timestamp: DateTime.now(),
//         accuracy: 0,
//         altitude: 0,
//         heading: 0,
//         speed: 0,
//         speedAccuracy: 0,
//       );
//     }
//
//     return await Geolocator.getCurrentPosition();
//   }
//
//   Future<void> saveLocation(Position position) async {
//     final prefs = await SharedPreferences.getInstance();
//     final locationData = {
//       'latitude': position.latitude,
//       'longitude': position.longitude,
//       'timestamp': DateTime.now().toIso8601String(),
//     };
//     await prefs.setString(_locationKey, json.encode(locationData));
//   }
//
//   Future<Map<String, dynamic>?> getSavedLocation() async {
//     final prefs = await SharedPreferences.getInstance();
//     final locationString = prefs.getString(_locationKey);
//     if (locationString != null) {
//       return json.decode(locationString);
//     }
//     return null;
//   }
//
//   double calculateDistance(double startLat, double startLng, double endLat, double endLng) {
//     return Geolocator.distanceBetween(startLat, startLng, endLat, endLng);
//   }
// }

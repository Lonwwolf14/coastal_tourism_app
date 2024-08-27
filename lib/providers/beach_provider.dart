// lib/providers/beach_provider.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/config.dart';
import '../models/beach.dart';

class BeachProvider {
  // Fetch list of beaches (mock data for now)
  static Future<List<Beach>> fetchBeaches() async {
    // Mock data
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    return [
      Beach(
        name: 'Goa Beach',
        location: 'Goa, India',
        description: 'A popular beach destination with vibrant nightlife.',
        latitude: 15.2993, // Example coordinates
        longitude: 74.1240,
      ),
      Beach(
        name: 'Kovalam Beach',
        location: 'Kerala, India',
        description: 'Known for its crescent-shaped beaches and serene atmosphere.',
        latitude: 8.4076, // Example coordinates
        longitude: 76.9828,
      ),
      Beach(
        name: 'Marina Beach',
        location: 'Chennai, India',
        description: 'One of the longest urban beaches in India, with a bustling atmosphere.',
        latitude: 13.0520, // Example coordinates
        longitude: 80.2555,
      ),
      // Add more mock beaches here
    ];

    // Uncomment when using real API
    /*
    final response = await http.get(Uri.parse(Config.beachesEndpoint));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => Beach(
        name: item['name'],
        location: item['location'],
        description: item['description'] ?? '',
        latitude: item['latitude'].toDouble(),
        longitude: item['longitude'].toDouble(),
      )).toList();
    } else {
      throw Exception('Failed to load beaches');
    }
    */
  }

  // Fetch beach details (mock data for now)
  static Future<Beach> fetchBeachDetails(String name) async {
    // Mock data
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    return Beach(
      name: 'Goa Beach',
      location: 'Goa, India',
      description: 'A popular beach destination with vibrant nightlife.',
      latitude: 15.2993, // Example coordinates
      longitude: 74.1240,
    );

    // Uncomment when using real API
    /*
    final response = await http.get(Uri.parse('${Config.beachesEndpoint}?name=$name'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Beach(
        name: data['name'],
        location: data['location'],
        description: data['description'] ?? '',
        latitude: data['latitude'].toDouble(),
        longitude: data['longitude'].toDouble(),
      );
    } else {
      throw Exception('Failed to fetch beach details');
    }
    */
  }
}

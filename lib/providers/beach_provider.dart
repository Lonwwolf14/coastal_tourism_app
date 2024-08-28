import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/config.dart';
import '../models/beach.dart';

class BeachProvider {
  static const _mockDelay = Duration(seconds: 2);

  static Future<List<Beach>> fetchBeaches(String searchQuery) async {
    if (Config.useMockData) {
      return _fetchMockBeaches();
    } else {
      return _fetchRealBeaches(searchQuery);
    }
  }

  static Future<Beach> fetchBeachDetails(String name) async {
    if (Config.useMockData) {
      return _fetchMockBeachDetails(name);
    } else {
      return _fetchRealBeachDetails(name);
    }
  }

  static Future<List<Beach>> _fetchMockBeaches() async {
    await Future.delayed(_mockDelay);
    return [
      Beach(
        name: 'Goa Beach',
        location: 'Goa, India',
        description: 'A popular beach destination with vibrant nightlife.',
        latitude: 15.2993,
        longitude: 74.1240,
      ),
      Beach(
        name: 'Kovalam Beach',
        location: 'Kerala, India',
        description: 'Known for its crescent-shaped beaches and serene atmosphere.',
        latitude: 8.4076,
        longitude: 76.9828,
      ),
      Beach(
        name: 'Marina Beach',
        location: 'Chennai, India',
        description: 'One of the longest urban beaches in India, with a bustling atmosphere.',
        latitude: 13.0520,
        longitude: 80.2555,
      ),
    ];
  }

  static Future<List<Beach>> _fetchRealBeaches(String searchQuery) async {
    final response = await http.get(Uri.parse('${Config.beachesEndpoint}?search=$searchQuery'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => Beach.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load beaches');
    }
  }

  static Future<Beach> _fetchMockBeachDetails(String name) async {
    await Future.delayed(_mockDelay);
    return Beach(
      name: 'Goa Beach',
      location: 'Goa, India',
      description: 'A popular beach destination with vibrant nightlife.',
      latitude: 15.2993,
      longitude: 74.1240,
    );
  }

  static Future<Beach> _fetchRealBeachDetails(String name) async {
    final response = await http.get(Uri.parse('${Config.beachesEndpoint}/$name'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Beach.fromJson(data);
    } else {
      throw Exception('Failed to fetch beach details');
    }
  }
}

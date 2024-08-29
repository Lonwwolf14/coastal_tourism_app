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
      Beach(
        name: 'Juhu Beach',
        location: 'Mumbai, India',
        description: 'Juhu is among the most expensive and affluent areas of the metropolitan area and home to many Bollywood celebrities.',
        latitude: 19.1048,
        longitude: 72.8267,
      ),
      Beach(
        name: 'Versova Beach',
        location: 'Mumbai, India',
        description: 'A popular beach destination with vibrant nightlife.',
        latitude: 19.1545,
        longitude: 72.8292,
      ),
      Beach(
        name: 'Marine Drive',
        location: 'Mumbai, India',
        description: 'Known as the Queens Necklace, is a famous promenade in Mumbai, India.',
        latitude: 18.9408,
        longitude: 72.8258,
      ),
      Beach(
        name: 'Aksa Beach',
        location: 'Mumbai, India',
        description: 'A popular beach destination with vibrant nightlife.',
        latitude: 19.2436,
        longitude: 72.8306,
      ),
      Beach(
        name: 'Alibag Beach',
        location: 'Raigad, India',
        description: 'A popular beach destination with vibrant nightlife.',
        latitude: 18.6406,
        longitude: 72.8328,
      ),
      Beach(
        name: 'Ganpatipule Beach',
        location: 'Ratnagiri, India',
        description: 'It is renowned for its immaculate white sand, glistening sea, and breathtaking Arabian Sea views.',
        latitude: 17.5264,
        longitude: 81.7364,
      ),
      Beach(
        name: 'Dadar Beach',
        location: 'Mumbai, India',
        description: 'A popular beach destination with vibrant nightlife.',
        latitude: 19.0168,
        longitude: 72.8347,
      ),
      Beach(
        name: 'Madh Island Beach',
        location: 'Mumbai, India',
        description: 'A popular beach destination with vibrant nightlife.',
        latitude: 19.2315,
        longitude: 72.8440,
      ),
      Beach(
        name: 'Diveagar Beach',
        location: 'Raigad, India',
        description: 'A popular beach destination with vibrant nightlife.',
        latitude: 18.2197,
        longitude: 72.9790,
      ),
      Beach(
        name: 'Kashid Beach',
        location: 'Raigad, India',
        description: 'A popular beach destination with vibrant nightlife.',
        latitude: 18.6364,
        longitude: 72.9630,
      ),
      Beach(
        name: 'Harihareshwar Beach',
        location: 'Raigad, India',
        description: 'A popular beach destination with vibrant nightlife.',
        latitude: 18.7211,
        longitude: 73.2892,
      ),
      Beach(
        name: 'Manori Beach',
        location: 'Mumbai, India',
        description: 'A popular beach destination with vibrant nightlife.',
        latitude: 19.2365,
        longitude: 72.8356,
      ),
      Beach(
        name: 'Guhagar Beach',
        location: 'Ratnagiri, India',
        description: 'A popular beach destination with vibrant nightlife.',
        latitude: 17.4977,
        longitude: 73.1536,
      ),
      Beach(
        name: 'Vengurla Beach',
        location: 'Sindhudurg, India',
        description: 'A popular beach destination with vibrant nightlife.',
        latitude: 15.8941,
        longitude: 73.6452,
      ),
      Beach(
        name: 'Bhatye Beach',
        location: 'Ratnagiri, India',
        description: 'A popular beach destination with vibrant nightlife.',
        latitude: 16.9817,
        longitude: 73.2893,
      ),
      Beach(
        name: 'Tarkarli Beach',
        location: 'Sindhudurg, India',
        description: 'A popular beach destination with vibrant nightlife.',
        latitude: 16.0250,
        longitude: 73.4267,
      ),
      Beach(
        name: 'Kihim Beach',
        location: 'Raigad, India',
        description: 'A popular beach destination with vibrant nightlife.',
        latitude: 18.6655,
        longitude: 72.9734,
      ),
      Beach(
        name: 'Dapoli Beach',
        location: 'Ratnagiri, India',
        description: 'A popular beach destination with vibrant nightlife.',
        latitude: 17.7490,
        longitude: 73.1158,
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

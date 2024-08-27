// lib/providers/beach_provider.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/config.dart';
import '../models/beach.dart';

class BeachProvider {
  static Future<List<Beach>> fetchBeaches() async {
    final response = await http.get(Uri.parse(Config.beachesEndpoint));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => Beach(
        name: item['name'],
        location: item['location'],
        // Add more fields if necessary
      )).toList();
    } else {
      throw Exception('Failed to load beaches');
    }
  }

  static Future<Beach> fetchBeachDetails(String name) async {
    final response = await http.get(Uri.parse('${Config.beachesEndpoint}?name=$name'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Beach(
        name: data['name'],
        location: data['location'],
        // Add more fields if necessary
      );
    } else {
      throw Exception('Failed to fetch beach details');
    }
  }
}

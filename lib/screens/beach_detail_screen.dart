// lib/screens/beach_detail_screen.dart

import 'package:flutter/material.dart';
import '../models/beach.dart';
import '../providers/beach_provider.dart';

class BeachDetailScreen extends StatelessWidget {
  final Beach beach;

  BeachDetailScreen({required this.beach});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(beach.name)),
      body: FutureBuilder<Beach>(
        future: BeachProvider.fetchBeachDetails(beach.name),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final beachDetails = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${beachDetails.name}', style: TextStyle(fontSize: 18)),
                  Text('Location: ${beachDetails.location}', style: TextStyle(fontSize: 18)),
                  // Add more details here as needed
                ],
              ),
            );
          } else {
            return Center(child: Text('No details available'));
          }
        },
      ),
    );
  }
}

// lib/screens/beach_list_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/beach.dart';
import '../providers/beach_provider.dart';
import 'beach_detail_screen.dart';

class BeachListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Beaches')),
      body: FutureBuilder<List<Beach>>(
        future: BeachProvider.fetchBeaches(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final beaches = snapshot.data!;

            return ListView.builder(
              itemCount: beaches.length,
              itemBuilder: (context, index) {
                final beach = beaches[index];
                return ListTile(
                  title: Text(beach.name),
                  subtitle: Text(beach.location),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BeachDetailScreen(beach: beach),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}

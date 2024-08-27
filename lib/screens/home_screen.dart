import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; // Make sure you have this package in your pubspec.yaml
import '../providers/beach_provider.dart';
import '../models/beach.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Beach>> _beachesFuture;

  @override
  void initState() {
    super.initState();
    _beachesFuture = BeachProvider.fetchBeaches();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coastal Tourism App'),
      ),
      body: FutureBuilder<List<Beach>>(
        future: _beachesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No beaches found.'));
          } else {
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
          }
        },
      ),
    );
  }
}

class BeachDetailScreen extends StatelessWidget {
  final Beach beach;

  BeachDetailScreen({required this.beach});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(beach.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              beach.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 8.0),
            Text(
              beach.location,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 16.0),
            Text(
              beach.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 16.0),
            // Example: Adding Google Maps widget (if needed)
            Container(
              height: 300,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(beach.latitude, beach.longitude),
                  zoom: 12,
                ),
                markers: {
                  Marker(
                    markerId: MarkerId(beach.name),
                    position: LatLng(beach.latitude, beach.longitude),
                    infoWindow: InfoWindow(
                      title: beach.name,
                      snippet: beach.location,
                    ),
                  ),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

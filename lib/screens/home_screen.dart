import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../providers/beach_provider.dart';
import '../models/beach.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coastal Tourism App'),
      ),
      body: FutureBuilder<List<Beach>>(
        future: BeachProvider.fetchBeaches(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No beaches found.'));
          } else {
            return BeachListView(beaches: snapshot.data!);
          }
        },
      ),
    );
  }
}

class BeachListView extends StatelessWidget {
  final List<Beach> beaches;

  const BeachListView({Key? key, required this.beaches}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}

class BeachDetailScreen extends StatelessWidget {
  final Beach beach;

  const BeachDetailScreen({Key? key, required this.beach}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(beach.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                beach.name,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8.0),
              Text(
                beach.location,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16.0),
              Text(
                beach.description,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16.0),
              SizedBox(
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
      ),
    );
  }
}
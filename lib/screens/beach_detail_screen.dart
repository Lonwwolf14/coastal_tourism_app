import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/beach.dart';

class BeachDetailScreen extends StatelessWidget {
  final Beach beach;

  const BeachDetailScreen({Key? key, required this.beach}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(beach.name),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                beach.name,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.teal, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Text(
                beach.location,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                beach.description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                ),
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
                      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
                    ),
                  },
                  myLocationEnabled: true,
                  zoomControlsEnabled: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
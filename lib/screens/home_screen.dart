import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../providers/beach_provider.dart';
import '../models/beach.dart';
import 'notifications_screen.dart';
import 'messages_screen.dart';
import 'profile_screen.dart'; // Import the new profile screen
import 'widgets/search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDark = false;
  String searchQuery = '';
  int currentPageIndex = 0;
  Location _location = Location();
  LocationData? _currentLocation;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      final locationData = await _location.getLocation();
      setState(() {
        _currentLocation = locationData;
      });
    } catch (e) {
      print('Could not get location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,
    );

    return Theme(
      data: themeData,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Image.asset('/assets/Aldenaire.png', height: 40), // Add your logo here
              const SizedBox(width: 10),
              const Text('Coastal Tourism App'),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(isDark ? Icons.brightness_2_outlined : Icons.wb_sunny_outlined),
              onPressed: () {
                setState(() {
                  isDark = !isDark;
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.my_location),
              onPressed: () {
                if (_currentLocation != null) {
                  print('Current location: ${_currentLocation!.latitude}, ${_currentLocation!.longitude}');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Could not get current location')),
                  );
                }
              },
            ),
          ],
        ),
        body: Column(
          children: [
            if (currentPageIndex == 0)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SearchBar(
                  hintText: 'Search beaches...',
                  onChanged: (query) {
                    setState(() {
                      searchQuery = query;
                    });
                  },
                  leading: const Icon(Icons.search),
                ),
              ),
            Expanded(
              child: getBodyContent(currentPageIndex),
            ),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          indicatorColor: Colors.amber,
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.notifications_sharp),
              label: 'Community',
            ),
            NavigationDestination(
              icon: Icon(Icons.messenger_sharp),
              label: 'Messages',
            ),
            NavigationDestination(
              icon: Icon(Icons.person), // Profile icon
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  Widget getBodyContent(int index) {
    switch (index) {
      case 0:
        return FutureBuilder<List<Beach>>(
          future: BeachProvider.fetchBeaches(searchQuery),
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
        );
      case 1:
        return const NotificationsScreen();
      case 2:
        return const MessagesScreen();
      case 3: // Profile screen index
        return const ProfileScreen(); // Navigate to ProfileScreen
      default:
        return Container();
    }
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
        return Card(
          elevation: 8.0,
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16.0),
            leading: Icon(Icons.beach_access, color: Colors.teal),
            title: Text(beach.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(beach.location),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BeachDetailScreen(beach: beach),
                ),
              );
            },
          ),
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

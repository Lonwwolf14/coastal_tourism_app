import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'notifications_screen.dart';
import 'messages_screen.dart';
import 'profile_screen.dart';
import 'search_screen.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'beach_detail_screen.dart';
import '../models/beach.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  bool isDark = false;
  int currentPageIndex = 0;
  Location _location = Location();
  LocationData? _currentLocation;
  late AnimationController _animationController;

  final List<Beach> nearbyBeaches = [
    Beach(
      name: 'Varkala Beach',
      location: 'Varkala, Kerala',
      description: 'Varkala Beach is known for its stunning cliff-side views and serene atmosphere.',
      latitude: 8.7378,
      longitude: 76.7164,
      imageUrl: 'https://example.com/varkala_beach.jpg',
    ),
    Beach(
      name: 'Kovalam Beach',
      location: 'Kovalam, Kerala',
      description: 'Kovalam Beach is famous for its crescent-shaped beaches and lighthouse.',
      latitude: 8.3988,
      longitude: 76.9782,
      imageUrl: 'https://example.com/kovalam_beach.jpg',
    ),
    Beach(
      name: 'Marari Beach',
      location: 'Mararikulam, Kerala',
      description: 'Marari Beach offers a peaceful and less crowded beach experience.',
      latitude: 9.5925,
      longitude: 76.3013,
      imageUrl: 'https://example.com/marari_beach.jpg',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
      colorScheme: isDark
          ? ColorScheme.dark(
        primary: Colors.tealAccent,
        secondary: Colors.orangeAccent,
        surface: Colors.grey[900]!,
      )
          : ColorScheme.light(
        primary: Colors.teal,
        secondary: Colors.orange,
        surface: Colors.grey[100]!,
      ),
    );

    return Theme(
      data: themeData,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Coastal Tourism App', style: TextStyle(fontWeight: FontWeight.bold)),
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _animationController.value * 2 * 3.14159,
                  child: IconButton(
                    icon: Icon(
                      isDark ? Icons.dark_mode : Icons.light_mode,
                      color: themeData.colorScheme.primary,
                    ),
                    onPressed: () {
                      setState(() {
                        isDark = !isDark;
                      });
                      _animationController.forward(from: 0);
                    },
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.my_location, color: themeData.colorScheme.primary),
              onPressed: () {
                if (_currentLocation != null) {
                  _showLocationSnackBar();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Could not get current location'),
                      backgroundColor: themeData.colorScheme.error,
                    ),
                  );
                }
              },
            ),
          ],
        ),
        body: SafeArea(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: getBodyContent(currentPageIndex),
          ),
        ),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          selectedIndex: currentPageIndex,
          destinations: <Widget>[
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.notifications_outlined),
              selectedIcon: Icon(Icons.notifications_rounded),
              label: 'Notifications',
            ),
            NavigationDestination(
              icon: Icon(Icons.search_outlined),
              selectedIcon: Icon(Icons.search_rounded),
              label: 'Search',
            ),
            NavigationDestination(
              icon: Icon(Icons.chat_bubble_outline_rounded),
              selectedIcon: Icon(Icons.chat_bubble_rounded),
              label: 'Messages',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline_rounded),
              selectedIcon: Icon(Icons.person_rounded),
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
        return AnimationLimiter(
          child: AnimationConfiguration.staggeredList(
            position: 0,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: ListView(
                  padding: EdgeInsets.all(16),
                  children: [
                    Text(
                      'Welcome to Coastal Tourism',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    _buildBeachSafetyCard(),
                    SizedBox(height: 16),
                    _buildNearbyBeachesList(),
                    SizedBox(height: 16),
                    _buildWeatherForecast(),
                  ],
                ),
              ),
            ),
          ),
        );
      case 1:
        return NotificationsScreen();
      case 2:
        return SearchScreen();
      case 3:
        return MessagesScreen();
      case 4:
        return ProfileScreen();
      default:
        return Container();
    }
  }

  Widget _buildBeachSafetyCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Beach Safety Status',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green),
                SizedBox(width: 8),
                Text('Safe for swimming'),
              ],
            ),
            SizedBox(height: 8),
            Text('Wave height: 0.5m'),
            Text('Water temperature: 25°C'),
          ],
        ),
      ),
    );
  }

  Widget _buildNearbyBeachesList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nearby Beaches',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: nearbyBeaches.length,
            itemBuilder: (context, index) {
              return _buildBeachCard(nearbyBeaches[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBeachCard(Beach beach) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.only(right: 16, bottom: 8),
      child: SizedBox(
        width: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
              child: Image.network(
                beach.imageUrl,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 120,
                    color: Colors.grey[300],
                    child: Icon(Icons.image_not_supported),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(beach.name, style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text(beach.location, style: TextStyle(fontSize: 12)),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BeachDetailScreen(beach: beach),
                        ),
                      );
                    },
                    child: Text('View Details'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherForecast() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Weather Forecast',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildWeatherDay('Mon', Icons.wb_sunny, '30°C'),
                _buildWeatherDay('Tue', Icons.cloud, '28°C'),
                _buildWeatherDay('Wed', Icons.beach_access, '29°C'),
                _buildWeatherDay('Thu', Icons.wb_sunny, '31°C'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherDay(String day, IconData icon, String temp) {
    return Column(
      children: [
        Text(day),
        Icon(icon),
        Text(temp),
      ],
    );
  }

  void _showLocationSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Current location: ${_currentLocation!.latitude}, ${_currentLocation!.longitude}',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
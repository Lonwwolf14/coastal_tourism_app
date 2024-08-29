import 'package:flutter/material.dart';
import 'notifications_screen.dart';
import 'messages_screen.dart';
import 'profile_screen.dart';
import 'search_screen.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'beach_detail_screen.dart';
import '../models/beach.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  bool isDark = false;
  int currentPageIndex = 0;
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
        return RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(Duration(seconds: 1));
            setState(() {
              // Update data here
            });
          },
          child: AnimationLimiter(
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
            SizedBox(height: 8),
            Text('UV Index: 6 (High)'),
            Text('Rip current risk: Low'),
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
              child: CachedNetworkImage(
                imageUrl: beach.imageUrl,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  height: 120,
                  color: Colors.grey[300],
                  child: Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => Container(
                  height: 120,
                  color: Colors.grey[300],
                  child: Icon(Icons.image_not_supported),
                ),
                memCacheWidth: 200,
                memCacheHeight: 120,
                maxWidthDiskCache: 200,
                maxHeightDiskCache: 120,
                fadeOutDuration: Duration(milliseconds: 300),
                fadeInDuration: Duration(milliseconds: 300),
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
}
// import 'package:flutter/material.dart';
// import 'package:coastal_tourism_app/services/beach_service.dart';
//
// class NearbyBeachesScreen extends StatefulWidget {
//   @override
//   _NearbyBeachesScreenState createState() => _NearbyBeachesScreenState();
// }
//
// class _NearbyBeachesScreenState extends State<NearbyBeachesScreen> {
//   final BeachService _beachService = BeachService();
//   List<Beach> _nearbyBeaches = [];
//   bool _isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadNearbyBeaches();
//   }
//
//   Future<void> _loadNearbyBeaches() async {
//     setState(() {
//       _isLoading = true;
//     });
//     try {
//       final beaches = await _beachService.getNearbyBeaches(10000); // 10km radius
//       setState(() {
//         _nearbyBeaches = beaches;
//       });
//     } catch (e) {
//       // Handle error
//       print('Error loading nearby beaches: $e');
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Nearby Beaches'),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//         itemCount: _nearbyBeaches.length,
//         itemBuilder: (context, index) {
//           final beach = _nearbyBeaches[index];
//           return ListTile(
//             title: Text(beach.name),
//             subtitle: Text('${beach.distance.toStringAsFixed(2)} km away'),
//           );
//         },
//       ),
//     );
//   }
// }

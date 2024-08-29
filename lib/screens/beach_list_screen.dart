// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../models/beach.dart';
// import '../providers/beach_provider.dart';
// import 'beach_detail_screen.dart';
//
// class BeachListScreen extends StatefulWidget {
//   const BeachListScreen({Key? key}) : super(key: key);
//
//   @override
//   _BeachListScreenState createState() => _BeachListScreenState();
// }
//
// class _BeachListScreenState extends State<BeachListScreen> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<BeachProvider>(context, listen: false).fetchBeaches();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Beaches'),
//       ),
//       body: Consumer<BeachProvider>(
//         builder: (context, beachProvider, child) {
//           if (beachProvider.beaches.isEmpty) {
//             return const Center(child: CircularProgressIndicator());
//           } else {
//             return BeachListView(beaches: beachProvider.beaches);
//           }
//         },
//       ),
//     );
//   }
// }
//
// class BeachListView extends StatelessWidget {
//   final List<Beach> beaches;
//
//   const BeachListView({Key? key, required this.beaches}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: beaches.length,
//       itemBuilder: (context, index) {
//         final beach = beaches[index];
//         return BeachListTile(beach: beach);
//       },
//     );
//   }
// }
//
// class BeachListTile extends StatelessWidget {
//   final Beach beach;
//
//   const BeachListTile({Key? key, required this.beach}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Text(beach.name),
//       subtitle: Text(beach.location),
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => BeachDetailScreen(beach: beach),
//           ),
//         );
//       },
//     );
//   }
// }

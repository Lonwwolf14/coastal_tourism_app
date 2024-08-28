import 'package:flutter/material.dart';
import '../models/beach.dart';
import '../providers/beach_provider.dart';

class BeachDetailScreen extends StatelessWidget {
  final Beach beach;

  const BeachDetailScreen({Key? key, required this.beach}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(beach.name)),
      body: FutureBuilder<Beach>(
        future: BeachProvider.fetchBeachDetails(beach.name),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return BeachDetailsView(beach: snapshot.data!);
          } else {
            return const Center(child: Text('No details available'));
          }
        },
      ),
    );
  }
}

class BeachDetailsView extends StatelessWidget {
  final Beach beach;

  const BeachDetailsView({Key? key, required this.beach}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BeachDetailItem(title: 'Name', value: beach.name, titleStyle: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            BeachDetailItem(title: 'Location', value: beach.location, titleStyle: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            BeachDetailItem(title: 'Description', value: beach.description, titleStyle: Theme.of(context).textTheme.titleMedium),
            // Add more details or visual elements as needed
          ],
        ),
      ),
    );
  }
}

class BeachDetailItem extends StatelessWidget {
  final String title;
  final String value;
  final TextStyle? titleStyle;

  const BeachDetailItem({
    Key? key,
    required this.title,
    required this.value,
    this.titleStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: titleStyle ?? Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 4),
        Text(value, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}
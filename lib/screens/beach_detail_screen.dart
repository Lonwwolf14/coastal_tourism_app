import 'package:flutter/material.dart';
import '../models/beach.dart';

class BeachDetailScreen extends StatelessWidget {
  final Beach beach;

  BeachDetailScreen({required this.beach});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(beach.name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              background: Image.network(
                beach.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      beach.description,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Location',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      beach.location,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
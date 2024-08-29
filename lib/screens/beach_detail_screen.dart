import 'package:flutter/material.dart';
import '../models/beach.dart';

class BeachDetailScreen extends StatelessWidget {
  final Beach beach;

  BeachDetailScreen({required this.beach});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(beach.name),
      ),
      body: Center(
        child: Text(beach.description),
      ),
    );
  }
}

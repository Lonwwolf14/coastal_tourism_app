import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Image
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/profile_placeholder.png'), // Placeholder image
              ),
            ),
            const SizedBox(height: 16.0),

            // Name
            Text(
              'User Name',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 8.0),

            // Email
            Text(
              'user.email@example.com',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16.0),

            // Bio
            Text(
              'Bio: This is a sample bio. Add more details about the user here.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 32.0),

            // Contact Info
            Text(
              'Contact Information',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8.0),
            Text('Phone: +123 456 7890'),
            Text('Address: 1234 Street, City, Country'),
            const SizedBox(height: 16.0),

            // Social Media Links
            Text(
              'Social Media',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.facebook),
                  onPressed: () {
                    // Open Facebook profile
                  },
                ),
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.twitter),
                  onPressed: () {
                    // Open Twitter profile
                  },
                ),
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.instagram),
                  onPressed: () {
                    // Open Instagram profile
                  },
                ),
              ],
            ),
            const SizedBox(height: 32.0),

            // Buttons
            ElevatedButton(
              onPressed: () {
                // Add functionality for editing profile
              },
              child: const Text('Edit Profile'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Add functionality for logging out
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Background color
              ),
              child: const Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}

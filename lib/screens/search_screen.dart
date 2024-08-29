import 'package:flutter/material.dart';
import '../providers/beach_provider.dart';
import '../models/beach.dart';
import 'widgets/search_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
          child: FutureBuilder<List<Beach>>(
            future: BeachProvider.fetchBeaches(''), // Fetch all beaches initially
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No beaches found.'));
              } else {
                // Filter the list of beaches based on the search query
                final filteredBeaches = snapshot.data!.where((beach) {
                  final queryLower = searchQuery.toLowerCase();
                  final nameLower = beach.name.toLowerCase();
                  final locationLower = beach.location.toLowerCase();
                  return nameLower.contains(queryLower) || locationLower.contains(queryLower);
                }).toList();

                // If there are no matches and the search query is not empty
                if (filteredBeaches.isEmpty && searchQuery.isNotEmpty) {
                  return const Center(child: Text('No beaches matched your search.'));
                }

                // If there are matches or the query is empty, show the list
                return BeachListView(beaches: filteredBeaches);
              }
            },
          ),
        ),
      ],
    );
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
        return ListTile(
          leading: const Icon(Icons.beach_access),
          title: Text(beach.name),
          subtitle: Text(beach.location),
          onTap: () {
            // Implement navigation to detailed beach information screen if needed
          },
        );
      },
    );
  }
}

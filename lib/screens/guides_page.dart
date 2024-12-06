import 'package:flutter/material.dart';

class GuidesPage extends StatelessWidget {
  final List<Map<String, String>> guides = [
    {'name': 'Guide X', 'email': 'guideX@example.com'},
    {'name': 'Guide Y', 'email': 'guideY@example.com'},
  ];

  GuidesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guides'),
      ),
      body: ListView.builder(
        itemCount: guides.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(guides[index]['name']!),
            subtitle: Text(guides[index]['email']!),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    // Navigate to update guide page
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    // Delete guide logic
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add guide page
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

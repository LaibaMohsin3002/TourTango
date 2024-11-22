import 'package:flutter/material.dart';

class GuidesPage extends StatelessWidget {
  final List<Map<String, String>> guides = [
    {'name': 'Guide X', 'email': 'guideX@example.com'},
    {'name': 'Guide Y', 'email': 'guideY@example.com'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guides'),
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
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Navigate to update guide page
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
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
        child: Icon(Icons.add),
      ),
    );
  }
}

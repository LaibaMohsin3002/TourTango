import 'package:flutter/material.dart';
import 'package_details_page.dart';
import 'guides_page.dart';
import 'add_package_page.dart';

class TourProviderHomePage extends StatelessWidget {
  final List<String> packages = [
    'Package A',
    'Package B',
    'Package C'
  ]; // Sample packages
  final List<String> guides = [
    'Guide X',
    'Guide Y',
    'Guide Z'
  ]; // Sample guides

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Packages and Guides'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Packages:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: packages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(packages[index]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PackageDetailsPage(packageName: packages[index]),
                      ),
                    );
                  },
                );
              },
            ),
            SizedBox(height: 20),
            Text(
              'Guides:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: guides.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(guides[index]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GuidesPage(),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPackagePage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

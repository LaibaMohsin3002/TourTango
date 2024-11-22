import 'package:flutter/material.dart';

class PackageDetailsPage extends StatelessWidget {
  final String packageName;

  PackageDetailsPage({required this.packageName});

  final List<String> customers = [
    'Customer A',
    'Customer B',
    'Customer C'
  ]; // Sample customers

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Package Details: $packageName'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Package Details:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Description of $packageName goes here...',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Customers Opted:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: customers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(customers[index]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

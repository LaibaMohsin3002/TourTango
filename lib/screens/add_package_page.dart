import 'package:flutter/material.dart';

class AddPackagePage extends StatelessWidget {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  void _addPackage() {
    // Logic to add package
    // Navigate back or show confirmation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Package'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Package Name'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Package Description'),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addPackage,
              child: Text('Add Package'),
            ),
          ],
        ),
      ),
    );
  }
}

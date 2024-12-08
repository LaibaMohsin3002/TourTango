import 'package:flutter/material.dart';
import 'package:tourtango/api.dart';

class AddGuidePage extends StatefulWidget {
  final String companyEmail;
  const AddGuidePage({super.key, required this.companyEmail});

  @override
  _AddGuidePageState createState() => _AddGuidePageState();
}

class _AddGuidePageState extends State<AddGuidePage> {
  late TextEditingController _guideNameController;

  String? _availability = 'Y';

  @override
  void initState() {
    super.initState();
    _guideNameController = TextEditingController();
  }

  Future<void> _addGuide() async {
    if (_guideNameController.text.isEmpty) {
      // Show error if the guide name is empty
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please enter a guide name'),
        backgroundColor: Colors.red,
      ));
      return;
    }
    try {
      await addGuide(
        companyEmail: widget.companyEmail,
        name: _guideNameController.text,
        availability: _availability,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Guide added successfully')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding guide: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Guide'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Guide Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _guideNameController,
                decoration: const InputDecoration(
                  labelText: 'Guide Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Availability',
                style: TextStyle(fontSize: 16),
              ),
              RadioListTile<String>(
                title: const Text('Yes'),
                value: 'Y',
                groupValue: _availability,
                onChanged: (value) {
                  setState(() {
                    _availability = value;
                  });
                },
              ),
              RadioListTile<String>(
                title: const Text('No'),
                value: 'N',
                groupValue: _availability,
                onChanged: (value) {
                  setState(() {
                    _availability = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _addGuide,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Add Guide'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tourtango/api.dart';

class AddGuidePage extends StatefulWidget {
  final String companyEmail;
  AddGuidePage({required this.companyEmail});

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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
        SnackBar(content: Text('Guide added successfully')),
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
        title: Text('Add Guide'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Guide Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _guideNameController,
                decoration: InputDecoration(
                  labelText: 'Guide Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Availability',
                style: TextStyle(fontSize: 16),
              ),
              RadioListTile<String>(
                title: Text('Yes'),
                value: 'Y',
                groupValue: _availability,
                onChanged: (value) {
                  setState(() {
                    _availability = value;
                  });
                },
              ),
              RadioListTile<String>(
                title: Text('No'),
                value: 'N',
                groupValue: _availability,
                onChanged: (value) {
                  setState(() {
                    _availability = value;
                  });
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _addGuide,
                child: Text('Add Guide'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
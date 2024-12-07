import 'package:flutter/material.dart';
import 'package:tourtango/api.dart';

class AddTransportPage extends StatefulWidget {
  final String companyEmail;
  AddTransportPage({required this.companyEmail});

  @override
  _AddTransportPageState createState() => _AddTransportPageState();
}

class _AddTransportPageState extends State<AddTransportPage> {
  late TextEditingController _driverNameController;
  late TextEditingController _vehicleTypeController;
  late TextEditingController _pickupLocationController;


  @override
  void initState() {
    super.initState();
    _driverNameController = TextEditingController();
    _vehicleTypeController = TextEditingController();
    _pickupLocationController = TextEditingController();
  }

  Future<void> _addTransport() async {
    if (_driverNameController.text.isEmpty || _vehicleTypeController.text.isEmpty || _pickupLocationController.text.isEmpty) {
      // Show error if the guide name is empty
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please fill empty fields'),
        backgroundColor: Colors.red,
      ));
      return;
    }
    try {
      await addTransport(
        companyEmail: widget.companyEmail,
        vehicleType: _vehicleTypeController.text,
        driverName: _driverNameController.text,
        pickupLocation: _pickupLocationController.text
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Transport added successfully')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding transport: $e')),
      );
    }
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Transport'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Transport Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _vehicleTypeController,
                decoration: InputDecoration(
                  labelText: 'Vehicle Type',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _driverNameController,
                decoration: InputDecoration(
                  labelText: 'Driver Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _pickupLocationController,
                decoration: InputDecoration(
                  labelText: 'Pickup Location',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _addTransport,
                child: Text('Add Transport'),
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
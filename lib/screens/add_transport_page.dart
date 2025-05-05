import 'package:flutter/material.dart';
import 'package:tourtango/api.dart';

class AddTransportPage extends StatefulWidget {
  final String companyEmail;
  const AddTransportPage({super.key, required this.companyEmail});

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
    if (_driverNameController.text.isEmpty ||
        _vehicleTypeController.text.isEmpty ||
        _pickupLocationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
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
          pickupLocation: _pickupLocationController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Transport added successfully')),
      );
      Navigator.pop(context, true);
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
        title: const Text('Add Transport'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Transport Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _vehicleTypeController,
                decoration: const InputDecoration(
                  labelText: 'Vehicle Type',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _driverNameController,
                decoration: const InputDecoration(
                  labelText: 'Driver Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _pickupLocationController,
                decoration: const InputDecoration(
                  labelText: 'Pickup Location',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _addTransport,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Add Transport'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

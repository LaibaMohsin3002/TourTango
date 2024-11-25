import 'dart:ffi';

import 'package:flutter/material.dart';
import '../api.dart'; 

class AddPackagePage extends StatefulWidget {
  @override
  _AddPackagePageState createState() => _AddPackagePageState();
}

class _AddPackagePageState extends State<AddPackagePage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _availabilityController = TextEditingController();
  final TextEditingController _tourCompanyIDController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _transportIDController = TextEditingController();
  final TextEditingController _guideIDController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

//NEEDS FIXING
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Call the API
      bool success = await addPackage(
        name: _nameController.text,
        price: double.parse(_priceController.text),
        availability: _availabilityController.text,
        tourCompanyID: int.parse(_tourCompanyIDController.text),
        startDate: _startDateController.text,
        endDate: _endDateController.text,
        transportID: int.parse(_transportIDController.text),
        guideID: int.parse(_guideIDController.text),
        country: _countryController.text,
      );

      // Show success or failure message
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Package added successfully!'),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to add package.'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Package'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) => value!.isEmpty ? 'Enter package name' : null,
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Enter package price' : null,
              ),
              TextFormField(
                controller: _availabilityController,
                decoration: InputDecoration(labelText: 'Availability (Y/N)'),
                validator: (value) =>
                    (value != 'Y' && value != 'N') ? 'Enter Y or N' : null,
              ),
              TextFormField(
                controller: _tourCompanyIDController,
                decoration: InputDecoration(labelText: 'Tour Company ID'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Enter Tour Company ID' : null,
              ),
              TextFormField(
                controller: _startDateController,
                decoration: InputDecoration(labelText: 'Start Date (YYYY-MM-DD)'),
                validator: (value) => value!.isEmpty ? 'Enter start date' : null,
              ),
              TextFormField(
                controller: _endDateController,
                decoration: InputDecoration(labelText: 'End Date (YYYY-MM-DD)'),
                validator: (value) => value!.isEmpty ? 'Enter end date' : null,
              ),
              TextFormField(
                controller: _transportIDController,
                decoration: InputDecoration(labelText: 'Transport ID'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Enter Transport ID' : null,
              ),
              TextFormField(
                controller: _guideIDController,
                decoration: InputDecoration(labelText: 'Guide ID'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Enter Guide ID' : null,
              ),
              TextFormField(
                controller: _countryController,
                decoration: InputDecoration(labelText: 'Country'),
                validator: (value) => value!.isEmpty ? 'Enter country' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

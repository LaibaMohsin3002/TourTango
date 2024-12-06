import 'dart:ffi';
import 'package:intl/intl.dart';
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
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _vehicleTypeController = TextEditingController();
  final TextEditingController _driverNameController = TextEditingController();
  final TextEditingController _pickupLocationController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _guideNameController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  Future<void> _pickDate(BuildContext context, TextEditingController controller) async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2024),
    lastDate: DateTime(2100),
  );
  if (pickedDate != null) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
    controller.text = formattedDate;
  }
}


  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Call the API
      bool success = await addPackage(
        name: _nameController.text,
        price: double.parse(_priceController.text),
        availability: _availabilityController.text,
        startDate: _startDateController.text,
        endDate: _endDateController.text,
        vehicleType: _vehicleTypeController.text,
        driverName: _driverNameController.text,
        pickupLocation:_pickupLocationController.text,
        companyName:_companyNameController.text,
        website:_websiteController.text,
        guideName:_guideNameController.text,
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
                controller: _startDateController,
                decoration: InputDecoration(labelText: 'Start Date'),
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode()); // Prevent keyboard from appearing
                  await _pickDate(context, _startDateController);
                },
              ),
              TextFormField(
                controller: _endDateController,
                decoration: InputDecoration(labelText: 'End Date'),
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode()); // Prevent keyboard from appearing
                  await _pickDate(context, _endDateController);
                },
              ),
              TextFormField(
                controller: _vehicleTypeController,
                decoration: InputDecoration(labelText: 'Vehicle Type'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Enter vehicle type' : null,
              ),
              TextFormField(
                controller: _driverNameController,
                decoration: InputDecoration(labelText: 'Driver Name'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Enter driver name' : null,
              ),
              TextFormField(
                controller: _pickupLocationController,
                decoration: InputDecoration(labelText: 'Pickup Location'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Enter pickup location' : null,
              ),
              TextFormField(
                controller: _companyNameController,
                decoration: InputDecoration(labelText: 'Company name'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Enter company name' : null,
              ),
              TextFormField(
                controller: _websiteController,
                decoration: InputDecoration(labelText: 'website'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Enter company website' : null,
              ),
              TextFormField(
                controller: _guideNameController,
                decoration: InputDecoration(labelText: 'Guide name'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Enter guide name' : null,
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

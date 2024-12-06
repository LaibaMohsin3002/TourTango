import 'package:flutter/material.dart';
import '../api.dart';

class AddPackagePage extends StatefulWidget {
  const AddPackagePage({super.key});

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
  final TextEditingController _pickupLocationController =
      TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _guideNameController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

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
        pickupLocation: _pickupLocationController.text,
        companyName: _companyNameController.text,
        website: _websiteController.text,
        guideName: _guideNameController.text,
        country: _countryController.text,
      );

      // Show success or failure message
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Package added successfully!'),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Failed to add package.'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Package'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Enter package name' : null,
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Enter package price' : null,
              ),
              TextFormField(
                controller: _availabilityController,
                decoration:
                    const InputDecoration(labelText: 'Availability (Y/N)'),
                validator: (value) =>
                    (value != 'Y' && value != 'N') ? 'Enter Y or N' : null,
              ),
              TextFormField(
                controller: _startDateController,
                decoration:
                    const InputDecoration(labelText: 'Start Date (YYYY-MM-DD)'),
                validator: (value) =>
                    value!.isEmpty ? 'Enter start date' : null,
              ),
              TextFormField(
                controller: _endDateController,
                decoration:
                    const InputDecoration(labelText: 'End Date (YYYY-MM-DD)'),
                validator: (value) => value!.isEmpty ? 'Enter end date' : null,
              ),
              TextFormField(
                controller: _vehicleTypeController,
                decoration: const InputDecoration(labelText: 'Vehicle Type'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Enter vehicle type' : null,
              ),
              TextFormField(
                controller: _driverNameController,
                decoration: const InputDecoration(labelText: 'Driver Name'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Enter driver name' : null,
              ),
              TextFormField(
                controller: _pickupLocationController,
                decoration: const InputDecoration(labelText: 'Pickup Location'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Enter pickup location' : null,
              ),
              TextFormField(
                controller: _companyNameController,
                decoration: const InputDecoration(labelText: 'Company name'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Enter company name' : null,
              ),
              TextFormField(
                controller: _websiteController,
                decoration: const InputDecoration(labelText: 'website'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Enter company website' : null,
              ),
              TextFormField(
                controller: _guideNameController,
                decoration: const InputDecoration(labelText: 'Guide name'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Enter guide name' : null,
              ),
              TextFormField(
                controller: _countryController,
                decoration: const InputDecoration(labelText: 'Country'),
                validator: (value) => value!.isEmpty ? 'Enter country' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

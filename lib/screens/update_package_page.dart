import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:tourtango/api.dart';

class UpdatePackagePage extends StatefulWidget {
  final int packageId;
  final String companyEmail;
  final Map<String, dynamic> recordDetails;

  UpdatePackagePage({required this.packageId, required this.companyEmail, required this.recordDetails,});

  @override
  _UpdatePackagePageState createState() => _UpdatePackagePageState();
}

class _UpdatePackagePageState extends State<UpdatePackagePage> {
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _startDateController;
  late TextEditingController _endDateController;
  late TextEditingController _vehicleTypeController;
  late TextEditingController _driverNameController;
  late TextEditingController _pickupLocationController;
  late TextEditingController _guideNameController;
  late TextEditingController _countryController;
  late TextEditingController _customerLimitController;

  String? _availability = 'Y';
  String? transportID;
  String? guideID;

  late Future<Map<String, dynamic>> companyDetailsFuture;
  late List<dynamic> guides;
  late List<dynamic> transport;

  late List<dynamic> flights = [];

  List<String> selectedFlightIDs = [];
  bool isLoadingFlights = false;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _priceController = TextEditingController();
    _startDateController = TextEditingController();
    _endDateController = TextEditingController();
    _vehicleTypeController = TextEditingController();
    _driverNameController = TextEditingController();
    _pickupLocationController = TextEditingController();
    _guideNameController = TextEditingController();
    _countryController = TextEditingController();
    _customerLimitController = TextEditingController();

    // Fetch company details when the page is initialized
    companyDetailsFuture = fetchCompanyDetails(widget.companyEmail);
    _initializeControllers(widget.recordDetails);
  }

  Future<void> _initializeControllers(Map<String, dynamic> recordDetails) async {
    _nameController = TextEditingController(text: recordDetails['packageName'] ?? '');
    _priceController = TextEditingController(text: recordDetails['price']?.toString() ?? '');
    _startDateController = TextEditingController(text: recordDetails['startDate'] ?? '');
    _endDateController = TextEditingController(text: recordDetails['endDate'] ?? '');
    _vehicleTypeController = TextEditingController(text: recordDetails['vehicleType'] ?? '');
    _driverNameController = TextEditingController(text: recordDetails['driverName'] ?? '');
    _pickupLocationController = TextEditingController(text: recordDetails['pickupLocation'] ?? '');
    _guideNameController = TextEditingController(text: recordDetails['guideName'] ?? '');
    _countryController = TextEditingController(text: recordDetails['country'] ?? '');
    _customerLimitController = TextEditingController(text: recordDetails['customerLimit'] ?? '');
  }

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

Future<void> _fetchFlights(int page) async {
  try {
    setState(() {
      isLoadingFlights = true;
    });
    final List<dynamic> response = await getFlights(); // Fetch flights via API
    setState(() {
      flights = response; // Directly assign the list
      isLoadingFlights = false;
    });
  } catch (e) {
    setState(() {
      isLoadingFlights = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error fetching flights: $e')),
    );
  }
}


  Future<void> _showFlightSelectionPopup() async {
    await _fetchFlights(currentPage);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Flights'),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 400, // Adjust height as needed
            child: isLoadingFlights
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: flights.length,
                    itemBuilder: (context, index) {
                      final flight = flights[index];
                      final flightID = flight['flightID'].toString();
                      final isSelected = selectedFlightIDs.contains(flightID);

                      return ListTile(
                        title: Text(flight['flightCompany']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Flight Company: ${flight['flightCompany']}'),
                            Text('Departure Time: ${flight['departureTime']}'),
                            Text('Arrival Time: ${flight['arrivalTime']}'),
                          ],
                        ),
                        trailing: Checkbox(
                          value: isSelected,
                          onChanged: (value) {
                            setState(() {
                              if (value == true) {
                                selectedFlightIDs.add(flightID);
                              } else {
                                selectedFlightIDs.remove(flightID);
                              }
                            });
                          },
                        ),
                      );
                    },
                  ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Done'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showScrollablePopup(String type) async {
    var selectedList = type == 'guides' ? guides : transport;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select $type'),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8, // Optional width constraint
            height: 300, // Adjust height as needed
            child: ListView.builder(
              itemCount: selectedList.length,
              itemBuilder: (context, index) {
                final item = selectedList[index];
                return ListTile(
                  title: Text(type == 'guides' && item['guideAvailability'] == 'Y' ? item['guideName'] : item['vehicleType']),
                  subtitle: type == 'transport' ? Text(item['driverName']) : null,
                  onTap: () {
                    setState(() {
                      if (type == 'guides'  && item['guideAvailability'] == 'Y') {
                        _guideNameController.text = item['guideName'];
                        guideID = item['guideID'];
                      } else {
                        _vehicleTypeController.text = item['vehicleType'];
                        _driverNameController.text = item['driverName'];
                        _pickupLocationController.text = item['pickupLocation'];
                        transportID = item['transportID'];
                      }
                    });
                    Navigator.pop(context); // Close the popup
                  },
                );
              },
            ),
          ),

        );
      },
    );
  }

  Future<void> _updatePackage() async {
    if (selectedFlightIDs.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Please select at least one flight')),
    );
    return;
  }
    try {
      await updatePackage(
        widget.packageId,
        name: _nameController.text,
        availability: _availability,
        guideID: guideID,
        transportID: transportID,
        startDate: _startDateController.text,
        endDate: _endDateController.text,
        country: _countryController.text,
        price: double.parse(_priceController.text),
        customerLimit: _customerLimitController.text,
        flightIDs: selectedFlightIDs
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Package updated successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating package: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Package'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: companyDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return Center(child: Text('No company details available'));
          }

          // Fetch guides and transport from company details
          guides = snapshot.data!['guides'] ?? [];
          transport = snapshot.data!['transport'] ?? [];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Package Details',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Package Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _priceController,
                    decoration: InputDecoration(
                      labelText: 'Price',
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
                  TextField(
                    controller: _startDateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Start Date',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    onTap: () => _pickDate(context, _startDateController),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _endDateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'End Date',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    onTap: () => _pickDate(context, _endDateController),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _countryController,
                    decoration: InputDecoration(
                      labelText: 'Country',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _customerLimitController,
                    decoration: InputDecoration(
                      labelText: 'Package Limit',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Select Guide',
                    style: TextStyle(fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () => _showScrollablePopup('guides'),
                    child: AbsorbPointer(
                      child: TextField(
                        controller: _guideNameController,
                        decoration: InputDecoration(
                          labelText: 'Guide Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Select Transport',
                    style: TextStyle(fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () => _showScrollablePopup('transport'),
                    child: AbsorbPointer(
                      child: TextField(
                        controller: _vehicleTypeController,
                        decoration: InputDecoration(
                          labelText: 'Vehicle Type',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Select Flights',
                    style: TextStyle(fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: _showFlightSelectionPopup,
                    child: AbsorbPointer(
                      child: TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText:
                              'Selected Flights (${selectedFlightIDs.length})',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _updatePackage,
                    child: Text('Update Package'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

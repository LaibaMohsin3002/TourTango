import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:tourtango/api.dart';

class AddPackagePage extends StatefulWidget {
  final String companyEmail;

  const AddPackagePage({super.key, required this.companyEmail});

  @override
  _AddPackagePageState createState() => _AddPackagePageState();
}

class _AddPackagePageState extends State<AddPackagePage> {
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
  late TextEditingController _descriptionController;
  late TextEditingController _imageUrlController;
  late TextEditingController _accommodationController;


  String? _availability = 'Y';
  int transportID = 0;
  int guideID = 0;
  int accommodationID = 0;

  late Future<Map<String, dynamic>> companyDetailsFuture;
  late List<dynamic> guides;
  late List<dynamic> transport;
  late List<dynamic> accommodation;
  late List<dynamic> flights;
   late List<dynamic> itineraries;
   bool isLoadingItineraries = false;

  List<String> selectedFlightIDs = [];
  List<String> selecteditineraryIDs = [];
  List<String> selecteditineraryDates = [];
  List<String> selecteditineraryTimeOfDay =[];
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
    _accommodationController = TextEditingController();
    _descriptionController = TextEditingController();
    _imageUrlController = TextEditingController();

    // Fetch company details when the page is initialized
    companyDetailsFuture = fetchCompanyDetails(widget.companyEmail);
    _fetchAccommodation();
  }

  Future<void> _pickDate(
      BuildContext context, TextEditingController controller) async {
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
  

  Future<void> _fetchAccommodation() async {
    try {
      final List<dynamic> response = await getAccommodations();
      setState(() {
        accommodation = response;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching accommodation: $e')),
      );
    }
  }

Future<void> _fetchFlights(int page) async {
  try {
    setState(() {
      isLoadingFlights = true;
    });
    final List<dynamic> response = await getFlights();
    setState(() {
      flights = response;
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
          title: const Text('Select Flights'),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 400, // Adjust height as needed
            child: isLoadingFlights
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: flights.length,
                    itemBuilder: (context, index) {
                      final flight = flights[index];
                      final flightID = flight['flightID'].toString();
                      final isSelected = selectedFlightIDs.contains(flightID);

                      return ListTile(
                        title: Text(flight['FlightCompany'] ?? "No company info"),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Departure Time: ${flight['departureTime'] ?? "N/A"}'),
                            Text('Arrival Time: ${flight['arrivalTime'] ?? "N/A"}'),
                          ],
                        ),
                        trailing: Checkbox(
                          value: isSelected,
                          activeColor: Colors.blue,
                          onChanged: (bool? value) {
                            setState(() {
                              if (value == true) {
                                if(!selectedFlightIDs.contains(flightID)){
                                selectedFlightIDs.add(flightID);}
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
              child: const Text('Done'),
            ),
          ],
        );
      },
    );
  }

 Future<void> _showItinerarySelectionPopup() async {
  await _fetchItineraries();
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Select or Create Itinerary'),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 400, // Adjust height as needed
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  // Open a dialog to add a new itinerary
                  _showAddItineraryDialog();
                },
                child: Text('Create New Itinerary'),
              ),
              SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: itineraries.length,
                  itemBuilder: (context, index) {
                    final itinerary = itineraries[index];
                    final itineraryID = itinerary['itineraryID'].toString();
                    final itineraryDate = itinerary['date'].toString();
                    final itineraryTimeOfDay = itinerary['time_of_day'];
                    final isSelected = selecteditineraryIDs.contains(itineraryID);

                    return ListTile(
                      title: Text(itinerary['activity_name']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Date: ${itinerary['date']}'),
                          Text('Time of Day: ${itinerary['time_of_day']}'),
                          Text('Description: ${itinerary['description']}'),
                          Text('City: ${itinerary['city']}'),
                        ],
                      ),
                      trailing: Checkbox(
                        value: isSelected,
                        activeColor: Colors.blue,
                        onChanged: (bool? value) {
                          setState(() {
                            if (value == true) {
                              // Add the selected item
                              if (!selecteditineraryIDs.contains(itineraryID)) {
                                selecteditineraryIDs.add(itineraryID);
                                selecteditineraryDates.add(itineraryDate);
                                selecteditineraryTimeOfDay.add(itineraryTimeOfDay);
                              }
                            } else {
                              // Remove the deselected item
                              final indexToRemove = selecteditineraryIDs.indexOf(itineraryID);
                              if (indexToRemove != -1) {
                                selecteditineraryIDs.removeAt(indexToRemove);
                                selecteditineraryDates.removeAt(indexToRemove);
                                selecteditineraryTimeOfDay.removeAt(indexToRemove);
                              }
                            }
                          });
                          print('Selected IDs: $selecteditineraryIDs');
                          print('Selected Dates: $selecteditineraryDates');
                          print('Selected Time of Day: $selecteditineraryTimeOfDay');
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
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

Future<void> _fetchItineraries() async {
    try {
      setState(() {
        isLoadingItineraries = true;
      });
      final List<dynamic> response = await getItineraries(); // Fetch itineraries via API
      setState(() {
        itineraries = response;
        isLoadingItineraries = false;
      });
    } catch (e) {
      setState(() {
        isLoadingItineraries = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching itineraries: $e')),
      );
    }
  }

Future<void> _showAddItineraryDialog() async {
  TextEditingController dateController = TextEditingController();
  TextEditingController timeOfDayController = TextEditingController();
  TextEditingController activityController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController activityDescriptionController = TextEditingController();
  

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Add New Itinerary'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: activityController,
              decoration: InputDecoration(
                labelText: 'Activity Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: activityDescriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: dateController,
              decoration: InputDecoration(
                labelText: 'Itinerary Date (YYYY-MM-DD)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: timeOfDayController,
              decoration: InputDecoration(
                labelText: 'Time of Day (e.g., Morning, Afternoon)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: cityController,
              decoration: InputDecoration(
                labelText: 'City',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              String itineraryDate = dateController.text;
              String timeOfDay = timeOfDayController.text;
              String activity = activityController.text;
              String description = activityDescriptionController.text;
              String city = cityController.text;

              // Make API call to create new itinerary
              try {
                await createItinerary(
                  itineraryDate: itineraryDate,
                  timeOfDay: timeOfDay,
                  activity: activity,
                  description: description,
                  city: city,
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Itinerary created successfully')),
                );
                Navigator.pop(context); // Close the dialog
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error creating itinerary: $e')),
                );
              }
            },
            child: Text('Create Itinerary'),
          ),
        ],
      );
    },
  );
}


Future<void> _showScrollablePopup(String type) async {
    var selectedList = type == 'guides' ? guides : type == 'transport' ? transport : accommodation;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select $type'),
          content: SizedBox(
            width: MediaQuery.of(context).size.width *
                0.8, // Optional width constraint
            height: 300, // Adjust height as needed
            child: ListView.builder(
              itemCount: selectedList.length,
              itemBuilder: (context, index) {
                final item = selectedList[index];
                return ListTile(
                  title: Text(type == 'accommodation' ? item['HotelName'] : type == 'guides' ? item['guideName'] : item['vehicleType']),
                  subtitle: type == 'accommodation'
                      ? Text('${item['plotNo']}, ${item['street_address']}, ${item['city']}, ${item['country']}')
                      : type == 'transport' ? Text(item['driverName']) : null,
                  onTap: () {
                    setState(() {
                      if (type == 'accommodation') {
                        _accommodationController.text = item['HotelName'];
                        accommodationID = item['accommodationID'];
                      } else if (type == 'guides') {
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

  Future<void> _addPackage() async {
  if (_nameController.text.isEmpty ||
        _priceController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _startDateController.text.isEmpty ||
        _endDateController.text.isEmpty ||
        _accommodationController.text.isEmpty ||
        selectedFlightIDs.isEmpty ||
        _countryController.text.isEmpty ||
        _imageUrlController.text.isEmpty ||
        _customerLimitController.text.isEmpty ||
        guideID==0 || transportID ==0 || accommodationID==0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }
    try {
      await addPackage(
        name: _nameController.text,
        availability: _availability,
        description: _descriptionController.text,
        guideID: guideID,
        transportID: transportID,
        startDate: _startDateController.text,
        endDate: _endDateController.text,
        country: _countryController.text,
        price: double.parse(_priceController.text),
        customerLimit: int.parse(_customerLimitController.text),
        accommodationID: accommodationID,
        flightIDs: selectedFlightIDs,
        itineraryIDs: selecteditineraryIDs,
        itineraryDates: selecteditineraryDates,
        itineraryTimeOfDay: selecteditineraryTimeOfDay,
        imageUrl: _imageUrlController.text,
        companyEmail: widget.companyEmail
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Package added successfully')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding package: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Package'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: companyDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('No company details available'));
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
                  const Text(
                    'Package Details',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Package Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _priceController,
                    decoration: const InputDecoration(
                      labelText: 'Price',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
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
                  TextField(
                    controller: _startDateController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'Start Date',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    onTap: () => _pickDate(context, _startDateController),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _endDateController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'End Date',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    onTap: () => _pickDate(context, _endDateController),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _countryController,
                    decoration: const InputDecoration(
                      labelText: 'Country',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _customerLimitController,
                    decoration: const InputDecoration(
                      labelText: 'Package Limit',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _imageUrlController,
                    decoration: InputDecoration(
                      labelText: 'Upload image URL for package',
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
                        decoration: const InputDecoration(
                          labelText: 'Guide Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Select Transport',
                    style: TextStyle(fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () => _showScrollablePopup('transport'),
                    child: AbsorbPointer(
                      child: TextField(
                        controller: _vehicleTypeController,
                        decoration: const InputDecoration(
                          labelText: 'Vehicle Type',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Select Accommodation',
                    style: TextStyle(fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () => _showScrollablePopup('accommodation'),
                    child: AbsorbPointer(
                      child: TextField(
                        controller: _accommodationController,
                        decoration: InputDecoration(
                          labelText: 'Hotel Name',
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
                   Text(
                'Select Itinerary(s)',
                style: TextStyle(fontSize: 16),
              ),
              GestureDetector(
                onTap: _showItinerarySelectionPopup,
                child: AbsorbPointer(
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Selected Itineraries (${selecteditineraryIDs.length}))',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _addPackage,
                    child: const Text('Add Package'),
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


// import 'dart:ffi';
// import 'package:intl/intl.dart';
// import 'package:flutter/material.dart';
// import '../api.dart';

// class AddPackagePage extends StatefulWidget {
//   const AddPackagePage({super.key});

//   @override
//   _AddPackagePageState createState() => _AddPackagePageState();
// }

// class _AddPackagePageState extends State<AddPackagePage> {
//   final _formKey = GlobalKey<FormState>();

//   // Controllers for text fields
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _priceController = TextEditingController();
//   final TextEditingController _availabilityController = TextEditingController();
//   final TextEditingController _startDateController = TextEditingController();
//   final TextEditingController _endDateController = TextEditingController();
//   final TextEditingController _vehicleTypeController = TextEditingController();
//   final TextEditingController _driverNameController = TextEditingController();
//   final TextEditingController _pickupLocationController =TextEditingController();
//   final TextEditingController _companyNameController = TextEditingController();
//   final TextEditingController _websiteController = TextEditingController();
//   final TextEditingController _guideNameController = TextEditingController();
//   final TextEditingController _countryController = TextEditingController();

//   Future<void> _pickDate(BuildContext context, TextEditingController controller) async {
//   DateTime? pickedDate = await showDatePicker(
//     context: context,
//     initialDate: DateTime.now(),
//     firstDate: DateTime(2024),
//     lastDate: DateTime(2100),
//   );
//   if (pickedDate != null) {
//     String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
//     controller.text = formattedDate;
//   }
// }


//   void _submitForm() async {
//     if (_formKey.currentState!.validate()) {
//       // Call the API
//       bool success = await addPackage(
//         name: _nameController.text,
//         price: double.parse(_priceController.text),
//         availability: _availabilityController.text,
//         startDate: _startDateController.text,
//         endDate: _endDateController.text,
//         vehicleType: _vehicleTypeController.text,
//         driverName: _driverNameController.text,
//         pickupLocation: _pickupLocationController.text,
//         companyName: _companyNameController.text,
//         website: _websiteController.text,
//         guideName: _guideNameController.text,
//         country: _countryController.text,
//       );

//       // Show success or failure message
//       if (success) {
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text('Package added successfully!'),
//         ));
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text('Failed to add package.'),
//         ));
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Package'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               TextFormField(
//                 controller: _nameController,
//                 decoration: const InputDecoration(labelText: 'Name'),
//                 validator: (value) =>
//                     value!.isEmpty ? 'Enter package name' : null,
//               ),
//               TextFormField(
//                 controller: _priceController,
//                 decoration: const InputDecoration(labelText: 'Price'),
//                 keyboardType: TextInputType.number,
//                 validator: (value) =>
//                     value!.isEmpty ? 'Enter package price' : null,
//               ),
//               TextFormField(
//                 controller: _availabilityController,
//                 decoration:
//                     const InputDecoration(labelText: 'Availability (Y/N)'),
//                 validator: (value) =>
//                     (value != 'Y' && value != 'N') ? 'Enter Y or N' : null,
//               ),
//               TextFormField(
//                 controller: _startDateController,
//                 decoration: InputDecoration(labelText: 'Start Date'),
//                 onTap: () async {
//                   FocusScope.of(context).requestFocus(FocusNode()); // Prevent keyboard from appearing
//                   await _pickDate(context, _startDateController);
//                 },
//               ),
//               TextFormField(
//                 controller: _endDateController,
//                 decoration: InputDecoration(labelText: 'End Date'),
//                 onTap: () async {
//                   FocusScope.of(context).requestFocus(FocusNode()); // Prevent keyboard from appearing
//                   await _pickDate(context, _endDateController);
//                 },
//               ),
//               TextFormField(
//                 controller: _vehicleTypeController,
//                 decoration: const InputDecoration(labelText: 'Vehicle Type'),
//                 keyboardType: TextInputType.number,
//                 validator: (value) =>
//                     value!.isEmpty ? 'Enter vehicle type' : null,
//               ),
//               TextFormField(
//                 controller: _driverNameController,
//                 decoration: const InputDecoration(labelText: 'Driver Name'),
//                 keyboardType: TextInputType.number,
//                 validator: (value) =>
//                     value!.isEmpty ? 'Enter driver name' : null,
//               ),
//               TextFormField(
//                 controller: _pickupLocationController,
//                 decoration: const InputDecoration(labelText: 'Pickup Location'),
//                 keyboardType: TextInputType.number,
//                 validator: (value) =>
//                     value!.isEmpty ? 'Enter pickup location' : null,
//               ),
//               TextFormField(
//                 controller: _companyNameController,
//                 decoration: const InputDecoration(labelText: 'Company name'),
//                 keyboardType: TextInputType.number,
//                 validator: (value) =>
//                     value!.isEmpty ? 'Enter company name' : null,
//               ),
//               TextFormField(
//                 controller: _websiteController,
//                 decoration: const InputDecoration(labelText: 'website'),
//                 keyboardType: TextInputType.number,
//                 validator: (value) =>
//                     value!.isEmpty ? 'Enter company website' : null,
//               ),
//               TextFormField(
//                 controller: _guideNameController,
//                 decoration: const InputDecoration(labelText: 'Guide name'),
//                 keyboardType: TextInputType.number,
//                 validator: (value) =>
//                     value!.isEmpty ? 'Enter guide name' : null,
//               ),
//               TextFormField(
//                 controller: _countryController,
//                 decoration: const InputDecoration(labelText: 'Country'),
//                 validator: (value) => value!.isEmpty ? 'Enter country' : null,
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _submitForm,
//                 child: const Text('Submit'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'add_package_page.dart';
import 'add_guide_page.dart';
import 'add_transport_page.dart';
import 'update_package_page.dart';
import 'package:tourtango/api.dart';

class TourProviderHomePage extends StatefulWidget {
  final String companyEmail;

  const TourProviderHomePage({super.key, required this.companyEmail});

  @override
  _TourProviderHomePageState createState() => _TourProviderHomePageState();
}

class _TourProviderHomePageState extends State<TourProviderHomePage> {
  late Future<Map<String, dynamic>> companyDetails;

  @override
  void initState() {
    super.initState();
    companyDetails = fetchCompanyDetails(widget.companyEmail);
  }

  void _showUpdateDialog(String endpoint, int id) async {
    final recordDetails = await fetchRecord(endpoint, id);

    final TextEditingController nameController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    final TextEditingController startDateController = TextEditingController();
    final TextEditingController endDateController = TextEditingController();
    final TextEditingController vehicleTypeController = TextEditingController();
    final TextEditingController driverNameController = TextEditingController();
    final TextEditingController pickupLocationController =
        TextEditingController();
    final TextEditingController guideNameController = TextEditingController();
    final TextEditingController countryController = TextEditingController();

    nameController.text = recordDetails['packageName'] ?? '';
    priceController.text = recordDetails['price']?.toString() ?? '';
    startDateController.text = recordDetails['startDate'] ?? '';
    endDateController.text = recordDetails['endDate'] ?? '';
    vehicleTypeController.text = recordDetails['vehicleType'] ?? '';
    driverNameController.text = recordDetails['driverName'] ?? '';
    pickupLocationController.text = recordDetails['pickupLocation'] ?? '';
    guideNameController.text = recordDetails['guideName'] ?? '';
    countryController.text = recordDetails['country'] ?? '';

    String? availability = 'Y';

    var companyData = await fetchCompanyDetails(widget.companyEmail);
    var guides = companyData['guides'] ?? [];
    var transport = companyData['transport'] ?? [];

    Future<void> pickDate(
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

    if (endpoint == 'packages') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UpdatePackagePage(
            packageId: id,
            companyEmail: widget.companyEmail,
            recordDetails: recordDetails,
          ),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Update $endpoint'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (endpoint == 'guides') ...[
                    const Text(
                      'Guide Details',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: guideNameController,
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
                      groupValue: availability,
                      onChanged: (value) {
                        setState(() {
                          availability = value;
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: const Text('No'),
                      value: 'N',
                      groupValue: availability,
                      onChanged: (value) {
                        setState(() {
                          availability = value;
                        });
                      },
                    ),
                  ],
                  if (endpoint == 'transport') ...[
                    const Text(
                      'Transport Details',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: vehicleTypeController,
                      decoration: const InputDecoration(
                        labelText: 'Vehicle Type',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: driverNameController,
                      decoration: const InputDecoration(
                        labelText: 'Driver Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: pickupLocationController,
                      decoration: const InputDecoration(
                        labelText: 'Pickup Location',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  // if (endpoint == 'packages') ...[
                  //   Text(
                  //     'Package Details',
                  //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  //   ),
                  //   SizedBox(height: 8),
                  //   TextField(
                  //     controller: _nameController,
                  //     decoration: InputDecoration(
                  //       labelText: 'Package Name',
                  //       border: OutlineInputBorder(),
                  //     ),
                  //   ),
                  //   SizedBox(height: 16),
                  //   TextField(
                  //     controller: _priceController,
                  //     decoration: InputDecoration(
                  //       labelText: 'Price',
                  //       border: OutlineInputBorder(),
                  //     ),
                  //   ),
                  //   SizedBox(height: 16),
                  //   Text(
                  //     'Availability',
                  //     style: TextStyle(fontSize: 16),
                  //   ),
                  //   RadioListTile<String>(
                  //     title: Text('Yes'),
                  //     value: 'Y',
                  //     groupValue: _availability,
                  //     onChanged: (value) {
                  //       setState(() {
                  //         _availability = value;
                  //       });
                  //     },
                  //   ),
                  //   RadioListTile<String>(
                  //     title: Text('No'),
                  //     value: 'N',
                  //     groupValue: _availability,
                  //     onChanged: (value) {
                  //       setState(() {
                  //         _availability = value;
                  //       });
                  //     },
                  //   ),
                  //   TextField(
                  //     controller: _startDateController,
                  //     readOnly: true,
                  //     decoration: InputDecoration(
                  //       labelText: 'Start Date',
                  //       border: OutlineInputBorder(),
                  //       suffixIcon: Icon(Icons.calendar_today),
                  //     ),
                  //     onTap: () => _pickDate(context, _startDateController),
                  //   ),
                  //   SizedBox(height: 16),
                  //   TextField(
                  //     controller: _endDateController,
                  //     readOnly: true,
                  //     decoration: InputDecoration(
                  //       labelText: 'End Date',
                  //       border: OutlineInputBorder(),
                  //       suffixIcon: Icon(Icons.calendar_today),
                  //     ),
                  //     onTap: () => _pickDate(context, _endDateController),
                  //   ),
                  //   SizedBox(height: 16),
                  //   TextField(
                  //     controller: _countryController,
                  //     decoration: InputDecoration(
                  //       labelText: 'Country',
                  //       border: OutlineInputBorder(),
                  //     ),
                  //   ),
                  //   SizedBox(height: 16),
                  //   Text(
                  //       'Select Guide',
                  //       style: TextStyle(fontSize: 16),
                  //     ),
                  //     Container(
                  //       height: 300, // Make the list scrollable
                  //       child: ListView.builder(
                  //         itemCount: guides.length,
                  //         itemBuilder: (context, index) {
                  //           final guide = guides[index];
                  //           return ListTile(
                  //             title: Text(guide['name']),
                  //             onTap: () {
                  //               setState(() {
                  //                 _guideNameController.text = guide['name'];
                  //               });
                  //               Navigator.pop(context); // Close the dialog after selection
                  //             },
                  //           );
                  //         },
                  //       ),
                  //     ),
                  //      Text(
                  //       'Select Transport',
                  //       style: TextStyle(fontSize: 16),
                  //     ),
                  //     Container(
                  //       height: 200, // Make the list scrollable
                  //       child: ListView.builder(
                  //         itemCount: transport.length,
                  //         itemBuilder: (context, index) {
                  //           final tp = transport[index];
                  //           return ListTile(
                  //             title: Text(tp['vehicleType']),
                  //             subtitle: Text(tp['driverName']),
                  //             onTap: () {
                  //               setState(() {
                  //                 _vehicleTypeController.text = tp['vehicleType'];
                  //                 _driverNameController.text = tp['driverName'];
                  //                 _pickupLocationController.text = tp['pickupLocation'];
                  //               });
                  //               Navigator.pop(context); // Close the dialog after selection
                  //             },
                  //           );
                  //         },
                  //       ),
                  //     ),
                  // ],
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  try {
                    if (endpoint == 'guides') {
                      await updateGuide(
                        id,
                        name: guideNameController.text,
                        availability: availability,
                      );
                    } else if (endpoint == 'transport') {
                      await updateTransport(
                        id,
                        vehicleType: vehicleTypeController.text,
                        driverName: driverNameController.text,
                        pickupLocation: pickupLocationController.text,
                      );
                    } //else if (endpoint == 'packages') {
                    //   await updatePackage(
                    //     id,
                    //     name: _nameController.text,
                    //     availability: _availability,
                    //     guideName: _guideNameController.text,
                    //     vehicleType: _vehicleTypeController.text,
                    //     driverName: _driverNameController.text,
                    //     pickupLocation: _pickupLocationController.text,
                    //     startDate: _startDateController.text,
                    //     endDate: _endDateController.text,
                    //     country: _countryController.text,
                    //     price: double.parse(_priceController.text),
                    //   );
                    // }
                    setState(() {
                      companyDetails = fetchCompanyDetails(widget.companyEmail);
                    });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('$endpoint updated successfully')));
                  } catch (e) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Error updating $endpoint: $e')));
                  }
                },
                child: const Text('Update'),
              ),
            ],
          );
        },
      );
    }
  }

  void _deleteItem(String endpoint, int id) async {
    try {
      await deleteItem(endpoint, id);
      setState(() {
        companyDetails = fetchCompanyDetails(widget.companyEmail);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete item')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Packages, Guides, and Transportation'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: companyDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data found'));
          }

          final packages = snapshot.data!['packages'];
          final guides = snapshot.data!['guides'];
          final transport = snapshot.data!['transport'];

          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              ListTile(
                title: const Text(
                  'Packages:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.add, color: Colors.blue),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AddPackagePage(companyEmail: widget.companyEmail),
                        ));
                  },
                ),
              ),
              ...packages.map((pkg) => ListTile(
                    title: Text(pkg['packageName']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Price: ${pkg['price']}'),
                        Text('Availability: ${pkg['availability']}'),
                        Text('Start Date: ${pkg['start_date']}'),
                        Text('End Date: ${pkg['end_date']}'),
                        Text('Guide Name: ${pkg['guideName']}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () =>
                              _showUpdateDialog('packages', pkg['packageID']),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () =>
                              _deleteItem('packages', pkg['packageID']),
                        ),
                      ],
                    ),
                  )),
              const SizedBox(height: 20),
              ListTile(
                title: const Text(
                  'Guides:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.add, color: Colors.blue),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddGuidePage(
                                companyEmail: widget.companyEmail,
                              )),
                    );
                  },
                ),
              ),
              ...guides.map((guide) => ListTile(
                    title: Text(guide['guideName']),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () =>
                              _showUpdateDialog('guides', guide['guideID']),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () =>
                              _deleteItem('guides', guide['guideID']),
                        ),
                      ],
                    ),
                  )),
              ListTile(
                title: const Text(
                  'Transportation:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.add, color: Colors.blue),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddTransportPage(
                              companyEmail: widget.companyEmail)),
                    );
                  },
                ),
              ),
              ...transport.map((tp) => ListTile(
                    title: Text(tp['vehicleType']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Driver Name: ${tp['driverName']}'),
                        Text('Pickup Location: ${tp['pickupLocation']}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () =>
                              _showUpdateDialog('transport', tp['transportID']),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () =>
                              _deleteItem('transport', tp['transportID']),
                        ),
                      ],
                    ),
                  )),
              const SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }
}

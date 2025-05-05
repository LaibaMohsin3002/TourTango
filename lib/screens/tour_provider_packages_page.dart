import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'add_package_page.dart';
import 'update_package_page.dart';
import 'package:tourtango/api.dart';

class TourProviderPackagesPage extends StatefulWidget {
  final String companyEmail;

  const TourProviderPackagesPage({super.key, required this.companyEmail});

  @override
  _TourProviderPackagesPageState createState() => _TourProviderPackagesPageState();
}

class _TourProviderPackagesPageState extends State<TourProviderPackagesPage> {
  late Future<Map<String, dynamic>> packageDetails;

  @override
  void initState() {
    super.initState();
    packageDetails = getPackages(widget.companyEmail);
  }

  void _showUpdateDialog(int id) async {
    final recordDetails = await fetchRecord('packages', id);

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
    }

  void _deleteItem(int id) async {
    try {
      await deleteItem('packages', id);
      setState(() {
        packageDetails = getPackages(widget.companyEmail);
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
        title: const Text('All packages'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: packageDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data found'));
          }

          final packages = snapshot.data!['packages'];

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
                  onPressed: () async {
                    final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AddPackagePage(companyEmail: widget.companyEmail),
                        ));
                    if (result == true) {
                      setState(() {
                        packageDetails =
                            getPackages(widget.companyEmail);
                      });
                    }
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
                              _showUpdateDialog(pkg['packageID']),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () =>
                              _deleteItem(pkg['packageID']),
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
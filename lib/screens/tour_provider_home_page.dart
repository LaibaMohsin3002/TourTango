import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'tour_provider_packages_page.dart';
import 'tour_provider_guides_page.dart';
import 'tour_provider_transport_page.dart';
import 'update_package_page.dart';
import 'package:tourtango/api.dart';
import 'provider_profile_page.dart';

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
                    }
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
        title: const Text('Welcome'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'User Info',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProfilePage(companyEmail: widget.companyEmail)),
                );
              },
            ),
            // ListTile(
            //   title: const Text('All packages'),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) =>
            //               BookingsPage(companyEmail: widget.companyEmail)),
            //     );
            //   },
            // ),
            // ListTile(
            //   title: const Text('All guides'),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => BookingHistoryPage(
            //               companyEmail: widget.companyEmail)),
            //     );
            //   },
            // ),
            // ListTile(
            //   title: const Text('All transportation'),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) =>
            //               FavouritesPage(customerEmail: widget.customerEmail)),
            //     );
            //   },
            // ),
            ListTile(
              title: const Text('Sign Out'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
//       body: FutureBuilder<Map<String, dynamic>>(
//         future: companyDetails,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text('No data found'));
//           }

//           final packages = snapshot.data!['packages'];
//           final guides = snapshot.data!['guides'];
//           final transport = snapshot.data!['transport'];

//           return ListView(
//             padding: const EdgeInsets.all(16.0),
//             children: [
//               ListTile(
//                 title: const Text(
//                   'Packages:',
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 trailing: IconButton(
//                   icon: const Icon(Icons.add, color: Colors.blue),
//                   onPressed: () async {
//                     final result = await Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               AddPackagePage(companyEmail: widget.companyEmail),
//                         ));
//                     if (result == true) {
//                       setState(() {
//                         companyDetails =
//                             fetchCompanyDetails(widget.companyEmail);
//                       });
//                     }
//                   },
//                 ),
//               ),
//               ...packages.map((pkg) => ListTile(
//                     title: Text(pkg['packageName']),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('Price: ${pkg['price']}'),
//                         Text('Availability: ${pkg['availability']}'),
//                         Text('Start Date: ${pkg['start_date']}'),
//                         Text('End Date: ${pkg['end_date']}'),
//                         Text('Guide Name: ${pkg['guideName']}'),
//                       ],
//                     ),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.edit),
//                           onPressed: () =>
//                               _showUpdateDialog('packages', pkg['packageID']),
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.delete),
//                           onPressed: () =>
//                               _deleteItem('packages', pkg['packageID']),
//                         ),
//                       ],
//                     ),
//                   )),
//               const SizedBox(height: 20),
//               ListTile(
//                 title: const Text(
//                   'Guides:',
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 trailing: IconButton(
//                   icon: const Icon(Icons.add, color: Colors.blue),
//                   onPressed: () async {
//                     final result = await Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => AddGuidePage(
//                                 companyEmail: widget.companyEmail,
//                               )),
//                     );

//                     if (result == true) {
//                       setState(() {
//                         companyDetails =
//                             fetchCompanyDetails(widget.companyEmail);
//                       });
//                     }
//                   },
//                 ),
//               ),
//               ...guides.map((guide) => ListTile(
//                     title: Text(guide['guideName']),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.edit),
//                           onPressed: () =>
//                               _showUpdateDialog('guides', guide['guideID']),
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.delete),
//                           onPressed: () =>
//                               _deleteItem('guides', guide['guideID']),
//                         ),
//                       ],
//                     ),
//                   )),
//               ListTile(
//                 title: const Text(
//                   'Transportation:',
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 trailing: IconButton(
//                   icon: const Icon(Icons.add, coloColor.fromARGB(255, 157, 170, 180)lue),
//                   onPressed: () async {
//                     final result = await Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => AddTransportPage(
//                               companyEmail: widget.companyEmail)),
//                     );

//                     if (result == true) {
//                       setState(() {
//                         companyDetails =
//                             fetchCompanyDetails(widget.companyEmail);
//                       });
//                     }
//                   },
//                 ),
//               ),
//               ...transport.map((tp) => ListTile(
//                     title: Text(tp['vehicleType']),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('Driver Name: ${tp['driverName']}'),
//                         Text('Pickup Location: ${tp['pickupLocation']}'),
//                       ],
//                     ),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.edit),
//                           onPressed: () =>
//                               _showUpdateDialog('transport', tp['transportID']),
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.delete),
//                           onPressed: () =>
//                               _deleteItem('transport', tp['transportID']),
//                         ),
//                       ],
//                     ),
//                   )),
//               const SizedBox(height: 20),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

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

    final totalBookings = snapshot.data!['totalBookings'];
    final activeTours = snapshot.data!['activeTours'];
    final activeTourPackages = snapshot.data!['activeTourPackages']; 
    final upcomingTourPackages = snapshot.data!['upcomingTourPackages'];

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // Total Bookings and Active Tours
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  '$totalBookings',
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const Text('Total Bookings This Month', style: TextStyle(fontSize: 14)),
              ],
            ),
            Column(
              children: [
                Text(
                  '$activeTours',
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const Text('Active Tours', style: TextStyle(fontSize: 14)),
              ],
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Active Tours Infinite Swiper
        const Text(
          'Active Tours',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        activeTourPackages == null || activeTourPackages.isEmpty
            ? const SizedBox(
                height: 100,
                child: Center(child: Text('No active tours available')),
              )
            : Container(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: activeTourPackages.length,
                  itemBuilder: (context, index) {
                    final pkg = activeTourPackages[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              pkg['imageUrl'] ?? '',
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.broken_image),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    pkg['name'] ?? 'Unnamed Package',
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text('Rating: ${pkg['average_rating'] ?? 'N/A'}'),
                                  Text('Price: ${pkg['price'] ?? 'N/A'}'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),


        const SizedBox(height: 20),

        // Upcoming Tours Infinite Swiper
        const Text(
          'Upcoming Tours',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        upcomingTourPackages == null || upcomingTourPackages.isEmpty
            ? const SizedBox(
                height: 100,
                child: Center(child: Text('No upcoming tours available')),
              )
            : Container(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: upcomingTourPackages.length,
                  itemBuilder: (context, index) {
                    final pkg = upcomingTourPackages[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              pkg['imageUrl'] ?? '',
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.broken_image),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    pkg['name'] ?? 'Unnamed Package',
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text('Rating: ${pkg['average_rating'] ?? 'N/A'}'),
                                  Text('Price: ${pkg['price'] ?? 'N/A'}'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),


        const SizedBox(height: 32),
        Center(
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 20),
                backgroundColor: Colors.blueAccent,
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TourProviderPackagesPage(companyEmail: widget.companyEmail)
                  ),
                );
              },
              child: const Text('Package Management'),
            ),
          ),
        ),
        const SizedBox(height: 32),
        Center(
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 20),
                backgroundColor: Colors.blueAccent,
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TourProviderGuidesPage(
                      companyEmail: widget.companyEmail,
                    ),
                  ),
                );
              },
              child: const Text('Guide Management'),
            ),
          ),
        ),
        const SizedBox(height: 32),
        Center(
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 20),
                backgroundColor: Colors.blueAccent,
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TourProviderTransportPage(
                      companyEmail: widget.companyEmail,
                    ),
                  ),
                );
              },
              child: const Text('Transport Management'),
            ),
          ),
        ),
      ],
    );
  },
),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'add_guide_page.dart';
import 'update_package_page.dart';
import 'package:tourtango/api.dart';
import 'provider_profile_page.dart';

class TourProviderGuidesPage extends StatefulWidget {
  final String companyEmail;

  const TourProviderGuidesPage({super.key, required this.companyEmail});

  @override
  _TourProviderGuidesPageState createState() => _TourProviderGuidesPageState();
}

class _TourProviderGuidesPageState extends State<TourProviderGuidesPage> {
  late Future<Map<String, dynamic>> guideDetails;

  @override
  void initState() {
    super.initState();
    guideDetails = getGuides(widget.companyEmail);
  }

  void _showUpdateDialog(int id) async {
    final recordDetails = await fetchRecord("guides", id);

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

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Update guide'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
              ),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  try {
                      await updateGuide(
                        id,
                        name: guideNameController.text,
                        availability: availability,
                      );
                    setState(() {
                      guideDetails = getGuides(widget.companyEmail);
                    });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Guide updated successfully')));
                  } catch (e) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Error updating guide: $e')));
                  }
                },
                child: const Text('Update'),
              ),
            ],
          );
        },
      );
    }

  void _deleteItem(int id) async {
    try {
      await deleteItem("guides", id);
      setState(() {
        guideDetails = getGuides(widget.companyEmail);
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
        title: const Text('All guides'),
      ),
      
       body: FutureBuilder<Map<String, dynamic>>(
         future: guideDetails,
         builder: (context, snapshot) {
           if (snapshot.connectionState == ConnectionState.waiting) {
             return const Center(child: CircularProgressIndicator());
           } else if (snapshot.hasError) {
             return Center(child: Text('Error: ${snapshot.error}'));
           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
             return const Center(child: Text('No data found'));
           }
           
           final guides = snapshot.data!['guides'];
           return ListView(
             padding: const EdgeInsets.all(16.0),
             children: [
               ListTile(
                 title: const Text(
                   'Guides:',
                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                 ),
                 trailing: IconButton(
                   icon: const Icon(Icons.add, color: Colors.blue),
                   onPressed: () async {
                     final result = await Navigator.push(
                       context,
                       MaterialPageRoute(
                           builder: (context) => AddGuidePage(
                                 companyEmail: widget.companyEmail,
                               )),
                     );
                     if (result == true) {
                       setState(() {
                         guideDetails =
                             getGuides(widget.companyEmail);
                       });
                     }
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
                               _showUpdateDialog(guide['guideID']),
                         ),
                         IconButton(
                           icon: const Icon(Icons.delete),
                           onPressed: () =>
                               _deleteItem(guide['guideID']),
                         ),
                       ],
                     ),
                   )),
             ],
           );
         },
       ),
     );
   }
 }
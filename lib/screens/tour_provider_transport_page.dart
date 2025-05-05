import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'add_transport_page.dart';
import 'package:tourtango/api.dart';

class TourProviderTransportPage extends StatefulWidget {
  final String companyEmail;

  const TourProviderTransportPage({super.key, required this.companyEmail});

  @override
  _TourProviderTransportPageState createState() => _TourProviderTransportPageState();
}

class _TourProviderTransportPageState extends State<TourProviderTransportPage> {
  late Future<Map<String, dynamic>> transportDetails;

  @override
  void initState() {
    super.initState();
    transportDetails = getTransport(widget.companyEmail);
  }

  void _showUpdateDialog(int id) async {
    final recordDetails = await fetchRecord("transport", id);

    final TextEditingController vehicleTypeController = TextEditingController();
    final TextEditingController driverNameController = TextEditingController();
    final TextEditingController pickupLocationController =
        TextEditingController();

    vehicleTypeController.text = recordDetails['vehicleType'] ?? '';
    driverNameController.text = recordDetails['driverName'] ?? '';
    pickupLocationController.text = recordDetails['pickupLocation'] ?? '';


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
            title: Text('Update transport'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
              ),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  try {
                      await updateTransport(
                        id,
                        vehicleType: vehicleTypeController.text,
                        driverName: driverNameController.text,
                        pickupLocation: pickupLocationController.text,
                      );
                    setState(() {
                      transportDetails = getTransport(widget.companyEmail);
                    });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Transport updated successfully')));
                  } catch (e) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Error updating transport: $e')));
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
      await deleteItem("transport", id);
      setState(() {
        transportDetails = getTransport(widget.companyEmail);
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
        title: const Text('All transport'),
      ),
       body: FutureBuilder<Map<String, dynamic>>(
         future: transportDetails,
         builder: (context, snapshot) {
           if (snapshot.connectionState == ConnectionState.waiting) {
             return const Center(child: CircularProgressIndicator());
           } else if (snapshot.hasError) {
             return Center(child: Text('Error: ${snapshot.error}'));
           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
             return const Center(child: Text('No data found'));
           }
           
           final transport = snapshot.data!['transportation'];
           return ListView(
             padding: const EdgeInsets.all(16.0),
             children: [
               ListTile(
                 title: const Text(
                   'Transportation:',
                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                 ),
                 trailing: IconButton(
                   icon: const Icon(Icons.add, color: Colors.blue),
                   onPressed: () async {
                     final result = await Navigator.push(
                       context,
                       MaterialPageRoute(
                           builder: (context) => AddTransportPage(
                               companyEmail: widget.companyEmail)),
                     );
                     if (result == true) {
                       setState(() {
                         transportDetails =
                             getTransport(widget.companyEmail);
                       });
                     }
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
                               _showUpdateDialog(tp['transportID']),
                         ),
                         IconButton(
                           icon: const Icon(Icons.delete),
                           onPressed: () =>
                               _deleteItem(tp['transportID']),
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
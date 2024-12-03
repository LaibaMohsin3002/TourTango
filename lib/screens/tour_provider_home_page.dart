import 'package:flutter/material.dart';
import 'package_details_page.dart';
import 'guides_page.dart';
import 'add_package_page.dart';
import 'package:tourtango/api.dart';

// class TourProviderHomePage extends StatelessWidget {
//   final List<String> packages = [
//     'Package A',
//     'Package B',
//     'Package C'
//   ]; // Sample packages
//   final List<String> guides = [
//     'Guide X',
//     'Guide Y',
//     'Guide Z'
//   ]; // Sample guides

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Your Packages and Guides'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Packages:',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             ListView.builder(
//               shrinkWrap: true,
//               itemCount: packages.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(packages[index]),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) =>
//                             PackageDetailsPage(packageName: packages[index]),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Guides:',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             ListView.builder(
//               shrinkWrap: true,
//               itemCount: guides.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(guides[index]),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => GuidesPage(),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => AddPackagePage()),
//           );
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }


class TourProviderHomePage extends StatefulWidget {
  final String companyEmail;

  TourProviderHomePage({required this.companyEmail});

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

  void _showUpdateDialog(String endpoint, int id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Item'),
          content: TextField(
            decoration: InputDecoration(hintText: 'Enter new details'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Call update function here
                Navigator.pop(context);
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void _deleteItem(String endpoint, int id) async {
    try {
      await deleteItem(endpoint, id);
      setState(() {
        companyDetails = fetchCompanyDetails(widget.companyEmail);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete item')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Packages, Guides, and Transportation'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: companyDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found'));
          }

          final packages = snapshot.data!['packages'];
          final guides = snapshot.data!['guides'];
          final transport = snapshot.data!['transport'];

          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Text('Packages:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ...packages.map((pkg) => ListTile(
                    title: Text(pkg['name']),
                    subtitle: Text('Price: ${pkg['price']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => _showUpdateDialog('packages', pkg['packageID']),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _deleteItem('packages', pkg['packageID']),
                        ),
                      ],
                    ),
                  )),
              SizedBox(height: 20),
              Text('Guides:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ...guides.map((guide) => ListTile(
                    title: Text(guide['name']),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => _showUpdateDialog('guides', guide['guideID']),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _deleteItem('guides', guide['guideID']),
                        ),
                      ],
                    ),
                  )),
              Text('Transportation:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                          icon: Icon(Icons.edit),
                          onPressed: () => _showUpdateDialog('transport', tp['transportID']),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _deleteItem('transport', tp['transportID']),
                        ),
                      ],
                    ),
                  )),
              SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }
}
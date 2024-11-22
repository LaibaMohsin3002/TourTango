// import 'package:flutter/material.dart';
// import 'profile_page.dart'; // Import Profile Page
// import 'booking_page.dart'; // Import Booking Page

// class CustomerHomePage extends StatefulWidget {
//   @override
//   _CustomerHomePageState createState() => _CustomerHomePageState();
// }

// class _CustomerHomePageState extends State<CustomerHomePage> {
//   final TextEditingController _searchController = TextEditingController();
//   List<String> tourPackages = [
//     'Beach Paradise',
//     'Mountain Adventure',
//     'Safari Expedition',
//     'City Tour',
//     'Cultural Experience'
//   ];

//   List<String> filteredTourPackages = [];

//   @override
//   void initState() {
//     super.initState();
//     filteredTourPackages = tourPackages;
//   }

//   void _filterPackages(String query) {
//     setState(() {
//       filteredTourPackages = tourPackages
//           .where(
//               (package) => package.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Welcome, Customer'),
//         backgroundColor: Colors.blue,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.exit_to_app),
//             onPressed: () {
//               // Sign out logic here
//               Navigator.pop(context);
//             },
//           ),
//         ],
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             DrawerHeader(
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//               ),
//               child: Text(
//                 'User Info',
//                 style: TextStyle(color: Colors.white, fontSize: 24),
//               ),
//             ),
//             ListTile(
//               title: Text('Profile'),
//               onTap: () {
//                 // Navigate to Profile Page
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => ProfilePage()),
//                 );
//               },
//             ),
//             ListTile(
//               title: Text('Bookings'),
//               onTap: () {
//                 // Navigate to Booking Page
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => BookingPage()),
//                 );
//               },
//             ),
//             ListTile(
//               title: Text('Sign Out'),
//               onTap: () {
//                 // Sign out logic
//                 Navigator.pop(context); // Close the drawer
//                 Navigator.pop(context); // Navigate back to start page
//               },
//             ),
//           ],
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Top 5 Hot Tour Packages',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 16),
//             TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 hintText: 'Search tour packages...',
//                 border: OutlineInputBorder(),
//                 prefixIcon: Icon(Icons.search),
//               ),
//               onChanged: _filterPackages,
//             ),
//             SizedBox(height: 16),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: filteredTourPackages.length,
//                 itemBuilder: (context, index) {
//                   return Card(
//                     margin: EdgeInsets.symmetric(vertical: 8),
//                     child: ListTile(
//                       title: Text(filteredTourPackages[index]),
//                       onTap: () {
//                         // Handle tour package selection
//                       },
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'profile_page.dart'; // Import Profile Page
import 'booking_page.dart'; // Import Booking Page
import 'customer_package_details.dart'; // Import Package Details Page

class CustomerHomePage extends StatefulWidget {
  @override
  _CustomerHomePageState createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> tourPackages = [
    'Beach Paradise',
    'Mountain Adventure',
    'Safari Expedition',
    'City Tour',
    'Cultural Experience'
  ];

  List<String> filteredTourPackages = [];

  @override
  void initState() {
    super.initState();
    filteredTourPackages = tourPackages;
  }

  void _filterPackages(String query) {
    setState(() {
      filteredTourPackages = tourPackages
          .where(
              (package) => package.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, Customer'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              // Sign out logic here
              Navigator.pop(context);
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'User Info',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () {
                // Navigate to Profile Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
            ListTile(
              title: Text('Bookings'),
              onTap: () {
                // Navigate to Booking Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookingPage()),
                );
              },
            ),
            ListTile(
              title: Text('Sign Out'),
              onTap: () {
                // Sign out logic
                Navigator.pop(context); // Close the drawer
                Navigator.pop(context); // Navigate back to start page
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Top 5 Hot Tour Packages',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search tour packages...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: _filterPackages,
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filteredTourPackages.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(filteredTourPackages[index]),
                      onTap: () {
                        // Navigate to Package Details Page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PackageDetailsPage(
                              packageName: filteredTourPackages[index],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

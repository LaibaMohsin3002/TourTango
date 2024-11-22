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
import 'package:carousel_slider/carousel_slider.dart';
import 'profile_page.dart'; // Import Profile Page
import 'booking_page.dart'; // Import Booking Page
import 'customer_package_details.dart'; // Import Package Details Page
import '../api.dart';

class CustomerHomePage extends StatefulWidget {
  @override
  _CustomerHomePageState createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey _searchBarKey = GlobalKey(); // Key for the search bar
  List<dynamic> tourPackages = [];
  List<dynamic> topPackages = [];
  List<dynamic> filteredSuggestions = [];
  bool isLoading = true;
  bool showSuggestions = false; // Toggle for showing suggestions
  double _suggestionBoxTop = 0.0; // Dynamic position for the suggestion box

  @override
  void initState() {
    super.initState();
    fetchHomePageData();
  }

  Future<void> fetchHomePageData() async {
    try {
      final data = await fetchHomePageDataFromAPI(); // API function
      if (data != null) {
        setState(() {
          tourPackages = data['tourPackages'] ?? [];
          topPackages = data['topPackages'] ?? [];
          isLoading = false;
        });
      } else {
        print('Data is null or empty');
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching packages: $error')),
      );
    }
  }

  void onSearchChanged(String query) {
    if (query.isEmpty) {
      setState(() {
        showSuggestions = false; // Hide suggestions if input is empty
        filteredSuggestions = [];
      });
      return;
    }

    setState(() {
      filteredSuggestions = tourPackages
          .where((package) =>
              package['name'].toString().toLowerCase().contains(query.toLowerCase()))
          .toList();
      showSuggestions = true; // Show suggestions when input is not empty
    });

    // Recalculate the suggestion box position
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final searchBox = _searchBarKey.currentContext?.findRenderObject() as RenderBox?;
      if (searchBox != null) {
        final searchBoxOffset = searchBox.localToGlobal(Offset.zero);
        setState(() {
          _suggestionBoxTop = searchBoxOffset.dy + searchBox.size.height; // Directly below the search bar
        });
      }
    });
  }

  void onSuggestionSelected(dynamic package) {
    setState(() {
      _searchController.text = package['name']; // Update the search bar text
      showSuggestions = false; // Hide suggestions
    });

    // Navigate to the package details page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PackageDetailsPage(
          packageName: package['name'],
        ),
      ),
    );
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
            ListTile(
              title: Text('Bookings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookingPage()),
                );
              },
            ),
            ListTile(
              title: Text('Sign Out'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                // Main Content
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      SizedBox(height: 16),

                      // Search Bar
                      TextField(
                        key: _searchBarKey, // Assign key to search bar
                        controller: _searchController,
                        onChanged: onSearchChanged,
                        decoration: InputDecoration(
                          hintText: 'Search tour packages...',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),

                      Text(
                        'Top 5 Hot Tour Packages',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),

                      // Carousel Slider for Top Packages
                      if (topPackages.isNotEmpty)
                        CarouselSlider.builder(
                          itemCount: topPackages.length,
                          options: CarouselOptions(
                            height: 400,
                            enlargeCenterPage: true,
                            autoPlay: true,
                            viewportFraction: 0.8,
                          ),
                          itemBuilder: (context, index, realIndex) {
                            final package = topPackages[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PackageDetailsPage(
                                      packageName: package['name'],
                                    ),
                                  ),
                                );
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      // image: DecorationImage(
                                      //   image: NetworkImage(package['image_url']),
                                      //   fit: BoxFit.cover,
                                      // ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 16,
                                    left: 16,
                                    child: Text(
                                      package['name'],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          Shadow(
                                            blurRadius: 6.0,
                                            color: Colors.black.withOpacity(0.8),
                                            offset: Offset(2.0, 2.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                ),

                // Search Suggestions
                if (showSuggestions)
                  Positioned(
                    top: _suggestionBoxTop, // Directly below the search bar
                    left: 16,
                    right: 16,
                    child: Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(8),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: filteredSuggestions.length,
                        itemBuilder: (context, index) {
                          final suggestion = filteredSuggestions[index];
                          return ListTile(
                            title: Text(suggestion['name']),
                            onTap: () => onSuggestionSelected(suggestion),
                          );
                        },
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}

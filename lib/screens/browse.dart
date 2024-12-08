import 'package:flutter/material.dart';
import 'package_details_page.dart';
import '../widgets/packages.dart'; // Add the recommended places widget
import '../api.dart';

class BrowsePage extends StatefulWidget {
  final String customerEmail;

  const BrowsePage({super.key, required this.customerEmail});

  @override
  _BrowsePageState createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> {
  final TextEditingController _searchController = TextEditingController();
  List<Package> tourPackages = [];
  List<Package> topPackages = [];
  List<Package> filteredPackages = [];
  List<dynamic> bookings = [];
  List<dynamic> faqs = [];
  bool isLoading = true;
  bool showSuggestions = false;
  double minPrice = 0.0; // For price filtering
  double maxPrice = 10000.0; // Maximum price value

  @override
  void initState() {
    super.initState();
    fetchHomePageData(widget.customerEmail);
  }

  Future<void> fetchHomePageData(String customerEmail) async {
    print(
        "Tour Packages: ${tourPackages.map((e) => e.specialOffers).toList()}");

    try {
      final data = await fetchHomePageDataFromAPI(customerEmail);
      setState(() {
        tourPackages = (data['tourPackages'] as List)
            .map((e) => Package.fromJson(e as Map<String, dynamic>))
            .toList();
        topPackages = (data['topPackages'] as List)
            .map((e) => Package.fromJson(e as Map<String, dynamic>))
            .toList();
        bookings = data['bookings'] ?? [];
        faqs = data['faqs'] ?? [];
        isLoading = false;
        filteredPackages = tourPackages; // Initial package list
      });
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
    filterPackages(query);
  }

  void filterPackages(String query) {
    setState(() {
      filteredPackages = tourPackages
          .where((package) =>
              package.packageName.toLowerCase().contains(query.toLowerCase()) &&
              package.price >= minPrice &&
              package.price <= maxPrice)
          .toList();
    });
  }

  void onPriceFilterChanged(double value) {
    setState(() {
      maxPrice = value;
      filterPackages(_searchController.text); // Reapply search filter
    });
  }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         foregroundColor: Colors.black,
//         title: const Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Browse Packages"),
//           ],
//         ),
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : ListView(
//               padding: const EdgeInsets.all(16),
//               children: [
//                 // Search bar
//                 TextField(
//                   controller: _searchController,
//                   onChanged: onSearchChanged,
//                   decoration: const InputDecoration(
//                     hintText: 'Search for tour packages...',
//                   ),
//                 ),
//                 // Price filter slider
//                 Row(
//                   children: [
//                     const Text("Price:"),
//                     Expanded(
//                       child: Slider(
//                         value: maxPrice,
//                         min: 0.0,
//                         max: 10000.0,
//                         divisions: 100,
//                         onChanged: onPriceFilterChanged,
//                       ),
//                     ),
//                     Text("\$${maxPrice.toStringAsFixed(2)}"),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 const Text(
//                   "Tour Packages",
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 10),
//                 // Display filtered packages
//                 for (var package in filteredPackages)
//                   ListTile(
//                     leading: Image.asset(
//                       package.imageUrl, // Corrected image path
//                       width: 50,
//                       height: 50,
//                       fit: BoxFit.cover,
//                     ),
//                     title: Text(package.packageName),
//                     subtitle: Text("\$${package.price}"),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => PackageDetailsPage(
//                             packageId: package.packageID,
//                             customerEmail: widget.customerEmail,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 const SizedBox(height: 20),
//                 // Other UI elements...
//               ],
//             ),
//     );
//   }
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Browse Packages"),
          ],
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Search bar
                TextField(
                  controller: _searchController,
                  onChanged: onSearchChanged,
                  decoration: const InputDecoration(
                    hintText: 'Search for tour packages...',
                  ),
                ),
                // Price filter slider
                Row(
                  children: [
                    const Text("Price:"),
                    Expanded(
                      child: Slider(
                        value: maxPrice,
                        min: 0.0,
                        max: 10000.0,
                        divisions: 100,
                        onChanged: onPriceFilterChanged,
                      ),
                    ),
                    Text("\$${maxPrice.toStringAsFixed(2)}"),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "Tour Packages",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                // Display filtered packages
                for (var package in filteredPackages)
                  ListTile(
                    leading: Image.asset(
                      package.imageUrl, // Corrected image path
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(package.packageName),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("\$${package.price}"),
                        if (package.specialOffers.isNotEmpty)
                          Text(
                            "Special Offer: ${package.specialOffers}",
                            style: TextStyle(
                              color: const Color.fromARGB(
                                  255, 99, 163, 115), // Highlight special offer
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PackageDetailsPage(
                            packageId: package.packageID,
                            customerEmail: widget.customerEmail,
                          ),
                        ),
                      );
                    },
                  ),
                const SizedBox(height: 20),
                // Other UI elements...
              ],
            ),
    );
  }
}

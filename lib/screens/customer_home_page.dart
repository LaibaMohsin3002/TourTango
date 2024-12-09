import 'package:flutter/material.dart';
import 'package_details_page.dart';
import 'profile_page.dart';
import 'booking_history.dart';
import 'browse.dart';
import 'my_bookings.dart';
import '../widgets/carousel.dart';
import '../widgets/packages.dart';
import '../widgets/location.dart';
import '../widgets/tourplaces.dart';
import '../widgets/recommendations.dart';
import '../api.dart';
import 'favourites_page.dart';

class CustomerHomePage extends StatefulWidget {
  final String customerEmail;

  const CustomerHomePage({super.key, required this.customerEmail});

  @override
  _CustomerHomePageState createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<Package> tourPackages = [];
  List<Package> topPackages = [];
  List<dynamic> bookings = [];
  List<dynamic> faqs = [];
  List<Package> filteredSuggestions = [];
  bool isLoading = true;
  bool showSuggestions = false;
  final double _suggestionBoxTop = 0.0;

  @override
  void initState() {
    super.initState();
    fetchHomePageData(widget.customerEmail);
  }

  Future<void> fetchHomePageData(String customerEmail) async {
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
    if (query.isEmpty) {
      setState(() {
        showSuggestions = false;
        filteredSuggestions = [];
      });
      return;
    }

    setState(() {
      filteredSuggestions = tourPackages
          .where((package) =>
              package.packageName.toLowerCase().contains(query.toLowerCase()))
          .toList();
      showSuggestions = true;
    });
  }

  void onSuggestionSelected(Package package) {
    setState(() {
      _searchController.text = package.packageName;
      showSuggestions = false;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PackageDetailsPage(
          packageId: package.packageID,
          customerEmail: widget.customerEmail,
        ),
      ),
    );
  }

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
            Text("Welcome"),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(left: 8.0, right: 12),
            child: IconButton(
              icon: Icon(Icons.notifications_none),
              onPressed: null,
            ),
          ),
        ],
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
                          ProfilePage(customerEmail: widget.customerEmail)),
                );
              },
            ),
            ListTile(
              title: const Text('Bookings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          BookingsPage(customerEmail: widget.customerEmail)),
                );
              },
            ),
            ListTile(
              title: const Text('Booking History'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BookingHistoryPage(
                          customerEmail: widget.customerEmail)),
                );
              },
            ),
            ListTile(
              title: const Text('Favourites'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          FavouritesPage(customerEmail: widget.customerEmail)),
                );
              },
            ),
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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const LocationCard(),
                const SizedBox(height: 20),
                const Text(
                  'Top 5 Hot Tour Packages',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                if (topPackages.isNotEmpty)
                  CarouselSliderWidget(
                    packages: topPackages,
                    onPackageTap: (package) {
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
                const Text(
                  "Tourist Places",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const TouristPlaces(),
                const SizedBox(height: 20),
                const Text(
                  "Recommended Places",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 250,
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return const RecommendedPlaces();
                    },
                  ),
                ),
                if (showSuggestions)
                  Positioned(
                    top: _suggestionBoxTop,
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
                            title: Text(suggestion.packageName),
                            onTap: () => onSuggestionSelected(suggestion),
                          );
                        },
                      ),
                    ),
                  ),
                const SizedBox(height: 20),
                const Text(
                  'Frequently Asked Questions',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                ...faqs.map((faq) => ExpansionTile(
                      title: Text(faq['question']),
                      children: <Widget>[
                        ListTile(
                          title: Text(faq['answer']),
                        ),
                      ],
                    )),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BrowsePage(
                          customerEmail: widget.customerEmail,
                        ),
                      ),
                    );
                  },
                  child: const Text('Browse Packages'),
                ),
              ],
            ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            // Navigate to Home page
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      BookingsPage(customerEmail: widget.customerEmail)),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ProfilePage(customerEmail: widget.customerEmail)),
            );
          }
        },
      ),
    );
  }
}

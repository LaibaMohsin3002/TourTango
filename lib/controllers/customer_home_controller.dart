import 'package:flutter/material.dart';
import '../screens/package_details_page.dart';
import '../models/packages.dart';
import '../api.dart';

class CustomerHomeController {
  final TextEditingController searchController = TextEditingController();
  List<Package> tourPackages = [];
  List<Package> topPackages = [];
  List<dynamic> bookings = [];
  List<dynamic> faqs = [];
  List<Package> filteredSuggestions = [];
  bool isLoading = true;
  bool showSuggestions = false;

  Future<void> fetchHomePageData(String customerEmail, Function setState) async {
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
    }
  }

  void onSearchChanged(String query, Function setState) {
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

  void onSuggestionSelected(Package package, Function setState, BuildContext context) {
    setState(() {
      searchController.text = package.packageName;
      showSuggestions = false;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PackageDetailsPage(
          packageId: package.packageID,
          customerEmail: 'random',
        ),
      ),
    );
  }
}

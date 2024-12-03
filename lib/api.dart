import 'dart:convert';
import 'package:http/http.dart' as http;

// Define a base URL for your API (make sure it has the correct protocol)
const String baseUrl = 'http://10.0.2.2:3000';

// Function to fetch home page data
Future<Map<String, dynamic>> fetchHomePageDataFromAPI() async {
  try {
    final response = await http.get(Uri.parse('$baseUrl/home'));

    if (response.statusCode == 200) {
      print('Response body: ${response.body}');  // Debugging the response
      return json.decode(response.body); // Decode and return the response
    } else {
      throw Exception('Failed to load home page data');
    }
  } catch (error) {
    print('Error: $error');
    throw Exception('Failed to load data');
  }
}

//   Future<bool> addPackage({
//   required String name,
//   required double price,
//   required String availability,
//   required int tourCompanyID,
//   required String startDate,
//   required String endDate,
//   required int transportID,
//   required int guideID,
//   required String country,
// }) async {

//   try {
//     final response = await http.post(
//   Uri.parse('$baseUrl/addPackage'),
//   headers: {'Content-Type': 'application/json'},
//   body: jsonEncode({
//     'name': name,
//     'price': price,
//     'availability': availability,
//     'tourCompanyID': tourCompanyID,
//     'start_date': startDate,
//     'end_date': endDate,
//     'transportID': transportID,
//     'guideID': guideID,
//     'country': country,
//   }),
// );


//     if (response.statusCode == 201) {
//       return true; // Success
//     } else {
//       print('Error: ${response.body}');
//       return false; // Failure
//     }
//   } catch (e) {
//     print('Exception: $e');
//     return false; // Error
//   }
// }

Future<bool> signUp(String companyName, String website, String email, String password) async {
    final url = Uri.parse("$baseUrl/company_signup");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "companyName": companyName,
        "website": website,
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      return true; // Sign-up successful
    } else {
      print('Error: ${response.body}');
      return false; // Sign-up failed
    }
  }


// Fetch all packages
Future<List<dynamic>> getPackages() async {
  try {
    final response = await http.get(Uri.parse('$baseUrl/packages'));
    
    if (response.statusCode == 200) {
      return json.decode(response.body);  // Returns list of packages
    } else {
      throw Exception('Failed to load packages');
    }
  } catch (error) {
    throw Exception('Error fetching packages: $error');
  }
}

// Add a new package
Future<bool> addPackage({
  required String name,
  required double price,
  required String availability,
  required String startDate,
  required String endDate,
  required String vehicleType,
  required String driverName,
  required String pickupLocation,
  required String companyName,
  required String website,
  required String guideName,
  required String country,
}) async {
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/packages'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'price': price,
        'availability': availability,
        'start_date': startDate,
        'end_date': endDate,
        'country': country,
        'vehicleType': vehicleType,
        'driverName': driverName,
        'pickupLocation': pickupLocation,
        'companyName': companyName,
        'guideName': guideName,
        'website': website,
      }),
    );

    if (response.statusCode == 201) {
      return true; // Success
    } else {
      print('Error: ${response.body}');
      return false; // Failure
    }
  } catch (e) {
    print('Exception: $e');
    return false; // Error
  }
}


// Fetch details of a specific package
Future<Map<String, dynamic>> getPackageDetails(int packageId) async {
  try {
    final response = await http.get(Uri.parse('$baseUrl/packages/$packageId'));

    if (response.statusCode == 200) {
      return json.decode(response.body);  // Returns the package details
    } else {
      throw Exception('Package not found');
    }
  } catch (error) {
    throw Exception('Error fetching package details: $error');
  }
}

// Update a specific package
Future<String> updatePackage(int packageId, Map<String, dynamic> updatedData) async {
  try {
    final response = await http.put(
      Uri.parse('$baseUrl/packages/$packageId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(updatedData),
    );
    
    if (response.statusCode == 200) {
      return 'Package updated successfully';
    } else {
      throw Exception('Failed to update package');
    }
  } catch (error) {
    throw Exception('Error updating package: $error');
  }
}

// Delete a specific package
Future<String> deletePackage(int packageId) async {
  try {
    final response = await http.delete(Uri.parse('$baseUrl/packages/$packageId'));

    if (response.statusCode == 200) {
      return 'Package deleted successfully';
    } else {
      throw Exception('Failed to delete package');
    }
  } catch (error) {
    throw Exception('Error deleting package: $error');
  }
}

Future<void> deleteItem(String endpoint, int id) async {
  final url = '$baseUrl/$endpoint/$id';
  final response = await http.delete(Uri.parse(url));
  if (response.statusCode != 200) {
    throw Exception('Failed to delete item');
  }
}

// Add a new guide
Future<bool> addGuide({
  required String name,
  required String availability,}) async {
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/guides'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'availability': availability,
      }),
    );

    if (response.statusCode == 201) {
      return true; // Success
    } else {
      print('Error: ${response.body}');
      return false; // Failure
    }
  } catch (e) {
    print('Exception: $e');
    return false; // Error
  }
}

Future<Map<String, dynamic>> fetchCompanyDetails(String companyEmail) async {
  final url = '$baseUrl/$companyEmail/details';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load company details');
  }
}

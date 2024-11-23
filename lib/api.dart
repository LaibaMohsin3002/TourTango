import 'dart:convert';
import 'package:http/http.dart' as http;

// Define a base URL for your API (make sure it has the correct protocol)
const String baseUrl = 'https://tt-api-one.vercel.app';

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

  Future<bool> addPackage({
  required String name,
  required double price,
  required String availability,
  required int tourCompanyID,
  required String startDate,
  required String endDate,
  required int transportID,
  required int guideID,
  required String country,
}) async {

  try {
    final response = await http.post(
  Uri.parse('$baseUrl/addPackage'),
  headers: {'Content-Type': 'application/json'},
  body: jsonEncode({
    'name': name,
    'price': price,
    'availability': availability,
    'tourCompanyID': tourCompanyID,
    'start_date': startDate,
    'end_date': endDate,
    'transportID': transportID,
    'guideID': guideID,
    'country': country,
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
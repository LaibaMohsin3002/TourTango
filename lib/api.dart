import 'dart:convert';
import 'package:http/http.dart' as http;

// Define a base URL for your API (make sure it has the correct protocol)
const String baseUrl = 'http://10.0.2.2:3000';

// Function to fetch home page data
Future<Map<String, dynamic>> fetchHomePageDataFromAPI(String customerEmail) async {
  try {
    final response = await http.get(Uri.parse('$baseUrl/$customerEmail/home'));

    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      return json.decode(response.body);
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
  required String? availability,
  required String description,
  required int guideID,
  required int transportID,
  required String startDate,
  required String endDate,
  required String country,
  required double price,
  required int customerLimit,
  required int accommodationID,
  required List<String> flightIDs,
  required List<String> itineraryIDs,
  required List<String> itineraryDates,
  required List<String> itineraryTimeOfDay,
  required String imageUrl,
  required String companyEmail
}) async {
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/$companyEmail/addPackage'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'packageName': name,
        'price': price,
        'availability': availability,
        'description': description,
        'start_date': startDate,
        'end_date': endDate,
        'country': country,
        'guideID': guideID, 
        'transportID': transportID,
        'accommodationID': accommodationID,
        'package_limit': customerLimit, 
        'image_url': imageUrl,
        'flightIDs': flightIDs,
        'itineraryIDs': itineraryIDs,
        'itineraryDates': itineraryDates,
        'itineraryTimeOfDay': itineraryTimeOfDay,
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

Future<void> createItinerary({
  required String itineraryDate,
  required String timeOfDay,
  required String activity,
  required String description,
  required String city,
}) async {
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/itinerary'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'activity': activity,
        'description': description,
        'time_of_day': timeOfDay,
        'date': itineraryDate,
        'city': city,
      }),
    );

   if (response.statusCode == 200) {
      // Successfully created itinerary
      print('Itinerary created');
    } else {
      // Handle error
      throw Exception('Failed to create itinerary');
    }
  } catch (e) {
    throw Exception('Error creating itinerary: $e');
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

// // Update a specific package
// Future<String> updatePackage(int packageId, Map<String, dynamic> updatedData) async {
//   try {
//     final response = await http.put(
//       Uri.parse('$baseUrl/packages/$packageId'),
//       headers: {'Content-Type': 'application/json'},
//       body: json.encode(updatedData),
//     );
    
//     if (response.statusCode == 200) {
//       return 'Package updated successfully';
//     } else {
//       throw Exception('Failed to update package');
//     }
//   } catch (error) {
//     throw Exception('Error updating package: $error');
//   }
// }

// Update a guide
Future<void> updateGuide(int id, {String? name, String? availability}) async {
  final url = Uri.parse('$baseUrl/guides/$id');
  final body = {
    if (name != null) 'guideName': name,
    if (availability != null) 'guideAvailability': availability,
  };
  final response = await http.put(url, body: jsonEncode(body), headers: {'Content-Type': 'application/json'});

  if (response.statusCode != 200) {
    throw Exception('Failed to update guide: ${response.body}');
  }
}

// Update a transport
Future<void> updateTransport(int id, {String? vehicleType, String? driverName, String? pickupLocation}) async {
  final url = Uri.parse('$baseUrl/transport/$id');
  final body = {
    if (vehicleType != null) 'vehicleType': vehicleType,
    if (driverName != null) 'driverName': driverName,
    if (pickupLocation != null) 'pickupLocation': pickupLocation,
  };
  final response = await http.put(url, body: jsonEncode(body), headers: {'Content-Type': 'application/json'});

  if (response.statusCode != 200) {
    throw Exception('Failed to update transport: ${response.body}');
  }
}

// Update a package
Future<void> updatePackage(
  int id, {
  required String name,
  required String? availability,
  required String description,
  required int guideID,
  required int transportID,
  required String startDate,
  required String endDate,
  required String country,
  required double price,
  required int customerLimit,
  required int accommodationID,
  required List<String> flightIDs,
  required List<String> itineraryIDs,
  required List<String> itineraryDates,
  required List<String> itineraryTimeOfDay,
  required String imageUrl
}) async {
  try {
    final response = await http.put(
      Uri.parse('$baseUrl/packages/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'packageName': name,
        'price': price,
        'availability': availability,
        'description': description,
        'start_date': startDate,
        'end_date': endDate,
        'country': country,
        'guideID': guideID, 
        'transportID': transportID,
        'accommodationID': accommodationID,
        'package_limit': customerLimit, 
        'image_url': imageUrl,
        'flightIDs': flightIDs,
        'itineraryIDs': itineraryIDs,
        'itineraryDates': itineraryDates,
        'itineraryTimeOfDay': itineraryTimeOfDay,
      }),
    );

    if (response.statusCode == 201) {
      print('Update successful');
    } else {
      print('Error: ${response.body}');
    }
  } catch (e) {
    print('Exception: $e');
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
  required String companyEmail,
  required String name,
  required String? availability,}) async {
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/$companyEmail/guides'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'guideName': name,
        'guideAvailability': availability,
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

// Add a new transport
Future<bool> addTransport({
  required String companyEmail,
  required String vehicleType,
  required String driverName, 
  required String pickupLocation}) async {
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/$companyEmail/transport'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'vehicleType': vehicleType,
        'driverName': driverName,
        'pickupLocation': pickupLocation
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

Future<Map<String, dynamic>> fetchRecord(String endpoint, int id) async {
  final url = '$baseUrl/$endpoint/$id';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to fetch record');
  }
}

Future<List<dynamic>> getFlights() async {
  final url = '$baseUrl/flights';
  final response = await http.get(Uri.parse(url));
  print(response);
  if (response.statusCode == 200) {
    return json.decode(response.body) as List<dynamic>;
    
  } else {
    throw Exception('Failed to fetch flights');
  }
}

Future<List<dynamic>> getItineraries() async {
  final url = '$baseUrl/itinerary';
  final response = await http.get(Uri.parse(url));
  print(response);
  if (response.statusCode == 200) {
    return json.decode(response.body) as List<dynamic>;
    
  } else {
    throw Exception('Failed to fetch itineraries');
  }
}

Future<List<dynamic>> getAccommodations() async {
  final url = '$baseUrl/accommodation';
  final response = await http.get(Uri.parse(url));
  print(response);
  if (response.statusCode == 200) {
    return json.decode(response.body) as List<dynamic>;
    
  } else {
    throw Exception('Failed to fetch accommodations');
  }
}

Future<List<dynamic>> fetchCustomerHistory(String customerEmail) async {
  final url = Uri.parse('$baseUrl/$customerEmail/history');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to fetch booking history');
  }
}

Future<void> submitReview(int bookingId, double rating, String comment) async {
  final response = await http.post(
    Uri.parse('$baseUrl/reviews'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({
      'bookingId': bookingId,
      'rating': rating,
      'comment': comment,
    }),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to submit review');
  }
}

Future<Map<String, dynamic>> fetchReview(int bookingId) async {
  final url = '$baseUrl/reviews/$bookingId';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to fetch record');
  }
}


Future<void> updateReview(int bookingID, double rating, String comment) async {
  final url = Uri.parse('$baseUrl/reviews/$bookingID');

  final response = await http.put(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'rating': rating,
      'comment': comment,
    }),
  );

  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    if (!responseData['success']) {
      throw Exception(responseData['message'] ?? 'Failed to update review');
    }
  } else {
    throw Exception('Failed to connect to the server');
  }
}


Future<void> createBookingTransaction(
    String customerEmail, int packageId, DateTime bookingDate, int noOfPeople, double paymentAmount, String paymentOption) async {
  final url = Uri.parse('$baseUrl/createBookingTransaction');
  final headers = {'Content-Type': 'application/json'};

  final body = json.encode({
    'customerEmail': customerEmail,
    'packageId': packageId,
    'bookingDate': bookingDate.toIso8601String(),
    'noOfPeople': noOfPeople,
    'paymentAmount': paymentAmount.toDouble(),
    'payment_mode': paymentOption
  });

  try {
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final statusMessage = data['statusMessage'];

      print('Transaction Status: $statusMessage');
      if (statusMessage == 'Transaction completed successfully.') {
        print('Booking ID: ${data['bookingID']}');
        print('Payment ID: ${data['paymentID']}');
      } else {
        print('Error: $statusMessage');
      }
    } else {
      print('Error: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

Future<void> addToFavorites({
  required String customerEmail,
  required int packageID,
}) async {
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/$customerEmail/favourites/$packageID'),
      headers: {'Content-Type': 'application/json'},);

   if (response.statusCode == 200) {
      print('Added to favourites');
    } else {
      // Handle error
      throw Exception('Failed to add to favourites');
    }
  } catch (e) {
    throw Exception('$e');
  }
}

Future<void> deleteFromFavourites({
  required String customerEmail,
  required int packageID,
}) async {
  try {
    final response = await http.delete(
      Uri.parse('$baseUrl/$customerEmail/favourites/$packageID'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print('Removed from favourites');
    } else {
      throw Exception('Failed to remove from favourites');
    }
  } catch (e) {
    throw Exception('$e');
  }
}

Future<List<dynamic>> getFavourites({required String customerEmail}) async {
  final url = '$baseUrl/$customerEmail/favourites';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return json.decode(response.body) as List<dynamic>;
    
  } else {
    throw Exception('Failed to fetch favourites');
  }
}


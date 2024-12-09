import 'dart:convert';
import 'package:http/http.dart' as http;


const String baseUrl = 'http://10.0.2.2:3000';

Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final body = json.encode({
      'email': email,
      'password': password,
    });

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );


      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        final errorData = json.decode(response.body);
        return {'error': errorData['error'] ?? 'Login failed'};
      }
    } catch (e) {
      return {'error': 'An error occurred: $e'};
    }
  }

//Function to fetch home page data
Future<Map<String, dynamic>> fetchHomePageDataFromAPI(String customerEmail,
    {String? filterBy}) async {
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

Future<bool> signUp(
    String companyName, String website, String email, String password) async {
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
    return true;
  } else {
    print('Error: ${response.body}');
    return false;
  }
}


//get custoner profile
Future<Map<String, dynamic>> fetchProfile(String customerEmail) async {
  final response = await http.get(Uri.parse('$baseUrl/profile/$customerEmail'));
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to fetch profile');
  }
}

//update customer profile
Future<void> updateProfile(
    String name, String email, String primaryPhone, String secondaryPhone, String customerEmail) async {
  final response = await http.put(
    Uri.parse('$baseUrl/profile/$customerEmail'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({
      'name': name,
      'email': email,
      'primaryPhone': primaryPhone,
      'secondaryPhone': secondaryPhone,
    }),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to update profile');
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
      return true; 
    } else {
      print('Error: ${response.body}');
      return false; 
    }
  } catch (e) {
    print('Exception: $e');
    return false; 
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
      print('Itinerary created');
    } else {
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
      return json.decode(response.body); 
    } else {
      throw Exception('Package not found');
    }
  } catch (error) {
    throw Exception('Error fetching package details: $error');
  }
}

// Update a guide
Future<void> updateGuide(int id, {String? name, String? availability}) async {
  final url = Uri.parse('$baseUrl/guides/$id');
  final body = {
    if (name != null) 'guideName': name,
    if (availability != null) 'guideAvailability': availability,
  };
  final response = await http.put(url,
      body: jsonEncode(body), headers: {'Content-Type': 'application/json'});

  if (response.statusCode != 200) {
    throw Exception('Failed to update guide: ${response.body}');
  }
}

// Update a transport
Future<void> updateTransport(int id,
    {String? vehicleType, String? driverName, String? pickupLocation}) async {
  final url = Uri.parse('$baseUrl/transport/$id');
  final body = {
    if (vehicleType != null) 'vehicleType': vehicleType,
    if (driverName != null) 'driverName': driverName,
    if (pickupLocation != null) 'pickupLocation': pickupLocation,
  };
  final response = await http.put(url,
      body: jsonEncode(body), headers: {'Content-Type': 'application/json'});

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
  required String? availability,
}) async {
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
      return true; 
    } else {
      print('Error: ${response.body}');
      return false; 
    }
  } catch (e) {
    print('Exception: $e');
    return false; 
  }
}

// Add a new transport
Future<bool> addTransport(
    {required String companyEmail,
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
      return true;
    } else {
      print('Error: ${response.body}');
      return false; 
    }
  } catch (e) {
    print('Exception: $e');
    return false; 
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
  const url = '$baseUrl/flights';
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

Future<List<dynamic>> fetchBookings(String customerEmail) async {
  final url = '$baseUrl/$customerEmail/bookings';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data['bookings'] ?? [];
  } else {
    throw Exception('Failed to load bookings');
  }
}

Future<void> deleteBooking(int bookingID) async {
  final response = await http.delete(Uri.parse('$baseUrl/bookings/$bookingID'));

  if (response.statusCode != 200) {
    throw Exception('Failed to delete booking');
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
    return Map<String, dynamic>.from(json.decode(response.body));
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
      
      print('Transaction success');
      } else {
        print('Error');
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


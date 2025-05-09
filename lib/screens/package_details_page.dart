import 'package:flutter/material.dart';
import 'package:tourtango/api.dart';
import 'package:tourtango/screens/booking_form_page.dart';
import 'booking_form_page.dart';
import 'package:ionicons/ionicons.dart';
import '/widgets/distance.dart';
import '/widgets/favourite.dart';

class PackageDetailsPage extends StatefulWidget {
  final int packageId;
  final String customerEmail;

  const PackageDetailsPage(
      {super.key, required this.packageId, required this.customerEmail});

  @override
  _PackageDetailsPageState createState() => _PackageDetailsPageState();
}

class _PackageDetailsPageState extends State<PackageDetailsPage> {
  late Future<Map<String, dynamic>> packageDetails;

  @override
  void initState() {
    super.initState();
    packageDetails = fetchRecord('packages', widget.packageId);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<Map<String, dynamic>>(
          future: packageDetails,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading...");
            } else if (snapshot.hasError) {
              return const Text("Error");
            } else if (snapshot.hasData) {
              final data = snapshot.data!;
              return Text(data['packageName'] ?? "Package Details");
            } else {
              return const Text("No Data");
            }
          },
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: packageDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            final itinerary = data['itinerary'] as List<dynamic>?;

            return SafeArea(
              child: ListView(
                padding: const EdgeInsets.all(10),
                children: [
                  SizedBox(
                    height: size.height * 0.38,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(20),
                            ),
                            image: DecorationImage(
                              image: AssetImage(data['imageUrl']),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.4),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 10,
                          left: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.7),
                              borderRadius: const BorderRadius.horizontal(
                                right: Radius.circular(15),
                              ),
                            ),
                            child: Favourite(
                              customerEmail: widget.customerEmail,
                              packageID: widget.packageId,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Row containing the Rating (Right) and Status (Left)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Status Shape on the Left
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          decoration: BoxDecoration(
                            color: data['availability'] == 'active'
                                ? Colors.green
                                : data['availability'] == 'upcoming'
                                    ? Colors.blue
                                    : Colors.grey,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            data['availability'] ?? "Unknown",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        // Rating (Star) on the Right
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.yellow, size: 20),
                            const SizedBox(width: 5),
                            Text(
                              data['average_rating'].toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Package Details
                  Text(
                    data['packageName'] ?? "Unknown Package",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 10),
                  Text("Country: ${data['country']}"),
                  Text("Hotel: ${data['hotelName']}"),
                  Text("Guide: ${data['guide'] ?? "No guide yet"}"),
                  Text("Vehicle: ${data['vehicleType']}"),
                  Text("Price: \$${data['price']}"),
                  Text("Description: ${data['description']}"),
                  const SizedBox(height: 20),
                  const Text(
                    "Itinerary",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  // Itinerary Details
                  itinerary != null && itinerary.isNotEmpty
                      ? Column(
                          children: itinerary.map((item) {
                            final itineraryItem = item as Map<String, dynamic>;
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                title: Text(itineraryItem['activity_name']),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Date: ${itineraryItem['date']}"),
                                    Text(
                                        "Time: ${itineraryItem['time_of_day']}"),
                                    Text("City: ${itineraryItem['city']}"),
                                    Text(
                                        "Description: ${itineraryItem['description']}"),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        )
                      : const Text("No itinerary available."),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingFormPage(
                            packageId: data['packageID'],
                            customerEmail: widget.customerEmail,
                            price: data['price'].toDouble(),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text('Book Now'),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text("No Data Available"));
          }
        },
      ),
    );
  }
}

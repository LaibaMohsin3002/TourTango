// import 'package:flutter/material.dart';
// import 'booking_form_page.dart'; // Import Booking Form Page

// class PackageDetailsPage extends StatelessWidget {
//   final String packageName;

//   const PackageDetailsPage({super.key, required this.packageName});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(packageName),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Package Details for $packageName',
//               style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'Description of $packageName:\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse efficitur.',
//               style: const TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'Price: \$299',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const Spacer(),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) =>
//                         BookingFormPage(packageName: packageName),
//                   ),
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 minimumSize: const Size(double.infinity, 50),
//               ),
//               child: const Text('Book Now'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:ionicons/ionicons.dart';
// import '/widgets/distance.dart';
// import 'booking_form_page.dart'; // Import Booking Form Page

// class TourPackageDetailsPage extends StatelessWidget {
//   final String packageName;
//   final String image;

//   const TourPackageDetailsPage({
//     Key? key,
//     required this.packageName,
//     required this.image,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(packageName),
//       ),
//       body: SafeArea(
//         child: ListView(
//           padding: const EdgeInsets.all(10),
//           children: [
//             // Image and Controls (Back & Heart)
//             SizedBox(
//               height: size.height * 0.38,
//               width: double.maxFinite,
//               child: Stack(
//                 fit: StackFit.expand,
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: const BorderRadius.vertical(
//                           bottom: Radius.circular(20)),
//                       image: DecorationImage(
//                         image: AssetImage(image),
//                         fit: BoxFit.cover,
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.4),
//                           spreadRadius: 0,
//                           blurRadius: 20,
//                           offset: const Offset(0, 10),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Positioned(
//                     top: 10,
//                     left: 0,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.7),
//                         borderRadius: const BorderRadius.horizontal(
//                             right: Radius.circular(15)),
//                       ),
//                       child: Row(
//                         children: [
//                           IconButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             iconSize: 20,
//                             icon: const Icon(Ionicons.chevron_back),
//                           ),
//                           IconButton(
//                             iconSize: 20,
//                             onPressed: () {},
//                             icon: const Icon(Ionicons.heart_outline),
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//             // Package Name, Distance, Rating
//             Row(
//               children: [
//                 Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       packageName,
//                       style: Theme.of(context).textTheme.titleLarge,
//                     ),
//                     const SizedBox(height: 5),
//                     Text(
//                       "Portic Team 8km", // Replace with dynamic distance
//                       style: Theme.of(context).textTheme.bodySmall,
//                     )
//                   ],
//                 ),
//                 const Spacer(),
//                 Padding(
//                   padding: const EdgeInsets.only(right: 4),
//                   child: IconButton(
//                     onPressed: () {},
//                     iconSize: 20,
//                     icon: const Icon(Ionicons.chatbubble_ellipses_outline),
//                   ),
//                 ),
//                 Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       "4.6", // Replace with dynamic rating
//                       style: Theme.of(context).textTheme.bodySmall,
//                     ),
//                     Icon(
//                       Ionicons.star,
//                       color: Colors.yellow[800],
//                       size: 15,
//                     )
//                   ],
//                 )
//               ],
//             ),
//             const SizedBox(height: 15),
//             // Timer
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       "01d:32h:56m", // Replace with dynamic countdown
//                       style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                             color: Theme.of(context).colorScheme.primary,
//                           ),
//                     ),
//                     const SizedBox(height: 5),
//                     Text(
//                       "Started in",
//                       style: Theme.of(context).textTheme.bodySmall,
//                     )
//                   ],
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             // Map (Image)
//             Container(
//               height: 180,
//               width: double.maxFinite,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15),
//                 color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
//                 image: const DecorationImage(
//                   image:
//                       AssetImage('assets/map.png'), // Replace with dynamic map
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 15),
//             // Distance Widget
//             const Distance(),
//             const SizedBox(height: 20),
//             // Booking Button
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) =>
//                         BookingFormPage(packageName: packageName),
//                   ),
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 minimumSize: const Size(double.infinity, 50),
//               ),
//               child: const Text('Book Now'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return Scaffold(
//       appBar: AppBar(
//         title: FutureBuilder<Map<String, dynamic>>(
//           future: packageDetails,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Text("Loading...");
//             } else if (snapshot.hasError) {
//               return const Text("Error");
//             } else {
//               final data = snapshot.data!;
//               return Text(data['packageName']);
//             }
//           },
//         ),
//       ),
//       body: FutureBuilder<Map<String, dynamic>>(
//         future: packageDetails,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text("Error: ${snapshot.error}"));
//           } else {
//             final data = snapshot.data!;
//             return SafeArea(
//               child: ListView(
//                 padding: const EdgeInsets.all(10),
//                 children: [
//                   // Image and Controls (Back & Heart)
//                   SizedBox(
//                     height: size.height * 0.38,
//                     width: double.maxFinite,
//                     child: Stack(
//                       fit: StackFit.expand,
//                       children: [
//                         Container(
//                           decoration: BoxDecoration(
//                             borderRadius: const BorderRadius.vertical(
//                                 bottom: Radius.circular(20)),
//                             image: DecorationImage(
//                               image: AssetImage(data['imageUrl']),
//                               fit: BoxFit.cover,
//                             ),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.4),
//                                 spreadRadius: 0,
//                                 blurRadius: 20,
//                                 offset: const Offset(0, 10),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Positioned(
//                           top: 10,
//                           left: 0,
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white.withOpacity(0.7),
//                               borderRadius: const BorderRadius.horizontal(
//                                   right: Radius.circular(15)),
//                             ),
//                             child: Row(
//                               children: [
//                                 IconButton(
//                                   onPressed: () {
//                                     Navigator.pop(context);
//                                   },
//                                   iconSize: 20,
//                                   icon: const Icon(Ionicons.chevron_back),
//                                 ),
//                                 IconButton(
//                                   iconSize: 20,
//                                   onPressed: () {},
//                                   icon: const Icon(Ionicons.heart_outline),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   // Package Name, Distance, Rating
//                   Row(
//                     children: [
//                       Column(
//                         mainAxisSize: MainAxisSize.min,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             data['packageName'],
//                             style: Theme.of(context).textTheme.titleLarge,
//                           ),
//                           const SizedBox(height: 5),
//                           Text(
//                             "Portic Team 8km", // Replace with dynamic distance
//                             style: Theme.of(context).textTheme.bodySmall,
//                           )
//                         ],
//                       ),
//                       const Spacer(),
//                       Padding(
//                         padding: const EdgeInsets.only(right: 4),
//                         child: IconButton(
//                           onPressed: () {},
//                           iconSize: 20,
//                           icon: const Icon(Ionicons.chatbubble_ellipses_outline),
//                         ),
//                       ),
//                       Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text(
//                             "4.6", // Replace with dynamic rating
//                             style: Theme.of(context).textTheme.bodySmall,
//                           ),
//                           Icon(
//                             Ionicons.star,
//                             color: Colors.yellow[800],
//                             size: 15,
//                           )
//                         ],
//                       )
//                     ],
//                   ),
//                   const SizedBox(height: 15),
//                   // Booking Button
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => BookingPage(
//                               packageId: data['packageID'], customerEmail: widget.customerEmail, price: data['price'].toDouble())
//                         ),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       minimumSize: const Size(double.infinity, 50),
//                     ),
//                     child: const Text('Book Now'),
//                   ),
//                 ],
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }

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
                  // Image and Controls (Back & Heart)
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
                                    Text("Time: ${itineraryItem['time_of_day']}"),
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

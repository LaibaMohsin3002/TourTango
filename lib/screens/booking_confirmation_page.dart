// // // // import 'package:flutter/material.dart';

// // // // class BookingConfirmationPage extends StatelessWidget {
// // // //   final String name;
// // // //   final String email;
// // // //   final String phone;
// // // //   final String packageName;

// // // //   const BookingConfirmationPage({
// // // //     super.key,
// // // //     required this.name,
// // // //     required this.email,
// // // //     required this.phone,
// // // //     required this.packageName,
// // // //   });

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       appBar: AppBar(
// // // //         title: const Text('Booking Confirmation'),
// // // //       ),
// // // //       body: Padding(
// // // //         padding: const EdgeInsets.all(16.0),
// // // //         child: Column(
// // // //           crossAxisAlignment: CrossAxisAlignment.start,
// // // //           children: [
// // // //             const Text(
// // // //               'Booking Confirmed!',
// // // //               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
// // // //             ),
// // // //             const SizedBox(height: 16),
// // // //             Text('Name: $name'),
// // // //             Text('Email: $email'),
// // // //             Text('Phone: $phone'),
// // // //             Text('Package: $packageName'),
// // // //             const Spacer(),
// // // //             ElevatedButton(
// // // //               onPressed: () {
// // // //                 // Navigate back to home
// // // //                 Navigator.popUntil(context, (route) => route.isFirst);
// // // //               },
// // // //               style: ElevatedButton.styleFrom(
// // // //                 minimumSize: const Size(double.infinity, 50),
// // // //               ),
// // // //               child: const Text('Go to Home'),
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // import 'package:flutter/material.dart';

// // // class BookingConfirmationPage extends StatelessWidget {
// // //   final String name;
// // //   final String email;
// // //   final String phone;
// // //   final String packageName;
// // //   final String tourCompany;
// // //   final String duration;
// // //   final String price;
// // //   final String bookingDate;

// // //   const BookingConfirmationPage({
// // //     super.key,
// // //     required this.name,
// // //     required this.email,
// // //     required this.phone,
// // //     required this.packageName,
// // //     required this.tourCompany,
// // //     required this.duration,
// // //     required this.price,
// // //     required this.bookingDate,
// // //   });

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       backgroundColor: const Color.fromARGB(255, 238, 242, 239), // Pastel green
// // //       appBar: AppBar(
// // //         title: const Text('Booking Confirmation'),
// // //         backgroundColor:
// // //             const Color.fromARGB(255, 100, 131, 156), // Pastel theme
// // //       ),
// // //       body: Padding(
// // //         padding: const EdgeInsets.all(16.0),
// // //         child: Column(
// // //           crossAxisAlignment: CrossAxisAlignment.start,
// // //           children: [
// // //             const SizedBox(height: 16),
// // //             Center(
// // //               child: const Text(
// // //                 'Booking Confirmed!',
// // //                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
// // //               ),
// // //             ),
// // //             const SizedBox(height: 32),
// // //             _buildInfoCard('Name', name),
// // //             const SizedBox(height: 16),
// // //             _buildInfoCard('Email', email),
// // //             const SizedBox(height: 16),
// // //             _buildInfoCard('Phone', phone),
// // //             const SizedBox(height: 16),
// // //             _buildInfoCard('Tour Company', tourCompany),
// // //             const SizedBox(height: 16),
// // //             _buildInfoCard('Duration', duration),
// // //             const SizedBox(height: 16),
// // //             _buildInfoCard('Price', price),
// // //             const SizedBox(height: 16),
// // //             _buildInfoCard('Package', packageName),
// // //             const SizedBox(height: 16),
// // //             _buildInfoCard('Booking Date', bookingDate),
// // //             const Spacer(),
// // //             ElevatedButton(
// // //               onPressed: () {
// // //                 Navigator.popUntil(context, (route) => route.isFirst);
// // //               },
// // //               style: ElevatedButton.styleFrom(
// // //                 backgroundColor: const Color.fromARGB(255, 160, 188, 177),
// // //                 minimumSize: const Size(double.infinity, 50),
// // //                 shape: RoundedRectangleBorder(
// // //                   borderRadius: BorderRadius.circular(25),
// // //                 ),
// // //               ),
// // //               child: const Text('Go to Home'),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildInfoCard(String label, String value) {
// // //     return Container(
// // //       padding: const EdgeInsets.all(16.0),
// // //       decoration: BoxDecoration(
// // //         color: Colors.white,
// // //         borderRadius: BorderRadius.circular(20),
// // //         boxShadow: [
// // //           BoxShadow(
// // //             color: Colors.black.withOpacity(0.1),
// // //             blurRadius: 5,
// // //             spreadRadius: 2,
// // //           ),
// // //         ],
// // //       ),
// // //       child: Row(
// // //         children: [
// // //           Icon(Icons.info, color: const Color.fromARGB(255, 100, 131, 156)),
// // //           const SizedBox(width: 16),
// // //           Expanded(
// // //             child: Text(
// // //               "$label: $value",
// // //               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }

// // import 'package:flutter/material.dart';

// // class BookingConfirmationPage extends StatelessWidget {
// //   final String name;
// //   final String email;
// //   final String phone;
// //   final String packageName;
// //   final String tourCompany;
// //   final String duration;
// //   final String price;
// //   final String bookingDate;

// //   const BookingConfirmationPage({
// //     super.key,
// //     required this.name,
// //     required this.email,
// //     required this.phone,
// //     required this.packageName,
// //     required this.tourCompany,
// //     required this.duration,
// //     required this.price,
// //     required this.bookingDate,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     // Trigger the notification
// //     //Future.delayed(Duration.zero, () {
// //     // notificationService.showNotification(
// //     //   id: 1,
// //     //   title: 'Booking Confirmed',
// //     //   body: 'Your booking for the package "$packageName" has been confirmed.',
// //     // );
// //     //});

// //     return Scaffold(
// //       backgroundColor: const Color.fromARGB(255, 238, 242, 239), // Pastel green
// //       appBar: AppBar(
// //         title: const Text('Booking Confirmation'),
// //         backgroundColor:
// //             const Color.fromARGB(255, 100, 131, 156), // Pastel theme
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             const SizedBox(height: 16),
// //             const Center(
// //               child: Text(
// //                 'Booking Confirmed!',
// //                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
// //               ),
// //             ),
// //             const SizedBox(height: 32),
// //             _buildInfoCard('Name', name),
// //             const SizedBox(height: 16),
// //             _buildInfoCard('Email', email),
// //             const SizedBox(height: 16),
// //             _buildInfoCard('Phone', phone),
// //             const SizedBox(height: 16),
// //             _buildInfoCard('Tour Company', tourCompany),
// //             const SizedBox(height: 16),
// //             _buildInfoCard('Duration', duration),
// //             const SizedBox(height: 16),
// //             _buildInfoCard('Price', price),
// //             const SizedBox(height: 16),
// //             _buildInfoCard('Package', packageName),
// //             const SizedBox(height: 16),
// //             _buildInfoCard('Booking Date', bookingDate),
// //             const Spacer(),
// //             ElevatedButton(
// //               onPressed: () {
// //                 Navigator.popUntil(context, (route) => route.isFirst);
// //               },
// //               style: ElevatedButton.styleFrom(
// //                 backgroundColor: const Color.fromARGB(255, 160, 188, 177),
// //                 minimumSize: const Size(double.infinity, 50),
// //                 shape: RoundedRectangleBorder(
// //                   borderRadius: BorderRadius.circular(25),
// //                 ),
// //               ),
// //               child: const Text('Go to Home'),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildInfoCard(String label, String value) {
// //     return Container(
// //       padding: const EdgeInsets.all(16.0),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(20),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.1),
// //             blurRadius: 5,
// //             spreadRadius: 2,
// //           ),
// //         ],
// //       ),
// //       child: Row(
// //         children: [
// //           const Icon(Icons.info, color: Color.fromARGB(255, 100, 131, 156)),
// //           const SizedBox(width: 16),
// //           Expanded(
// //             child: Text(
// //               "$label: $value",
// //               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:tourtango/notification.dart'; // Import your NotificationService

// class BookingConfirmationPage extends StatelessWidget {
//   final String name;
//   final String email;
//   final String phone;
//   final String packageName;
//   final String tourCompany;
//   final String duration;
//   final String price;
//   final String bookingDate;
//   final String numberOfPeople;

//   const BookingConfirmationPage({
//     super.key,
//     required this.name,
//     required this.email,
//     required this.phone,
//     required this.packageName,
//     required this.tourCompany,
//     required this.duration,
//     required this.price,
//     required this.bookingDate,
//     required this.numberOfPeople,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // Trigger the notification after the widget is fully built
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       NotificationService().showNotification(
//         id: 1,
//         title: 'Booking Confirmed',
//         body: 'Your booking for the package "$packageName" has been confirmed.',
//       );
//     });

//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 238, 242, 239), // Pastel green
//       appBar: AppBar(
//         title: const Text('Booking Confirmation'),
//         backgroundColor:
//             const Color.fromARGB(255, 100, 131, 156), // Pastel theme
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 16),
//             const Center(
//               child: Text(
//                 'Booking Confirmed!',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//             ),
//             const SizedBox(height: 32),
//             _buildInfoCard('Name', name),
//             const SizedBox(height: 16),
//             _buildInfoCard('Email', email),
//             const SizedBox(height: 16),
//             _buildInfoCard('Phone', phone),
//             const SizedBox(height: 16),
//             _buildInfoCard('Tour Company', tourCompany),
//             const SizedBox(height: 16),
//             _buildInfoCard('Duration', duration),
//             const SizedBox(height: 16),
//             _buildInfoCard('Price', price),
//             const SizedBox(height: 16),
//             _buildInfoCard('Package', packageName),
//             const SizedBox(height: 16),
//             _buildInfoCard('Booking Date', bookingDate),
//             const SizedBox(height: 16),
//             _buildInfoCard('Number of people', numberOfPeople),
//             const Spacer(),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.popUntil(context, (route) => route.isFirst);
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color.fromARGB(255, 160, 188, 177),
//                 minimumSize: const Size(double.infinity, 50),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(25),
//                 ),
//               ),
//               child: const Text('Go to Home'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoCard(String label, String value) {
//     return Container(
//       padding: const EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 5,
//             spreadRadius: 2,
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.info, color: Color.fromARGB(255, 100, 131, 156)),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Text(
//               "$label: $value",
//               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:tourtango/notification.dart'; // Import your NotificationService
import 'payment_page.dart'; // Import PaymentPage

class BookingConfirmationPage extends StatelessWidget {
  final String name;
  final String email;
  final String phone;
  final int packageId;
  final String tourCompany;
  final String duration;
  final double price;
  final String bookingDate;
  final String numberOfPeople;

  const BookingConfirmationPage({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
    required this.packageId,
    required this.tourCompany,
    required this.duration,
    required this.price,
    required this.bookingDate,
    required this.numberOfPeople,
  });

  Future<void> _navigateToPayment(BuildContext context) async {
    int people = int.parse(numberOfPeople);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentPage(
          // packageId: 1, // Replace with actual package ID if needed
          // customerEmail: email,
          // price: double.parse(price),
          // noOfPeople: people,

          packageId: packageId,
          customerEmail: email,
          price: price,
          noOfPeople: people,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Trigger the notification after the widget is fully built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      NotificationService().showNotification(
        id: 1,
        title: 'Booking Confirmed',
        body: 'Your booking for the package "$packageId" has been confirmed.',
      );
    });

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 242, 239), // Pastel green
      appBar: AppBar(
        title: const Text('Booking Confirmation'),
        backgroundColor:
            const Color.fromARGB(255, 100, 131, 156), // Pastel theme
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Center(
              child: Text(
                'Booking Confirmed!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 32),
            _buildInfoCard('Name', name),
            const SizedBox(height: 16),
            _buildInfoCard('Email', email),
            const SizedBox(height: 16),
            _buildInfoCard('Phone', phone),
            const SizedBox(height: 16),
            _buildInfoCard('Tour Company', tourCompany),
            const SizedBox(height: 16),
            _buildInfoCard('Duration', duration),
            const SizedBox(height: 16),
            // _buildInfoCard('Price', price as String),
            _buildInfoCard('Price', '\$${price.toStringAsFixed(2)}'),
            const SizedBox(height: 16),
            _buildInfoCard('Package', packageId.toString()),
            //_buildInfoCard('Package', packageId as String),
            const SizedBox(height: 16),
            _buildInfoCard('Booking Date', bookingDate),
            const SizedBox(height: 16),
            _buildInfoCard('Number of People', numberOfPeople),

            const Spacer(),
            ElevatedButton(
              onPressed: () => _navigateToPayment(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 176, 174, 196),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text('Proceed to Payment'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.info, color: Color.fromARGB(255, 100, 131, 156)),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              "$label: $value",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

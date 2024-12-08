// // // import 'package:flutter/material.dart';
// // // import 'package:tourtango/api.dart';

// // // class PaymentPage extends StatefulWidget {
// // //   final int packageId;
// // //   final String customerEmail;
// // //   final double price;
// // //   final int noOfPeople;

// // //   const PaymentPage(
// // //       {super.key,
// // //       required this.packageId,
// // //       required this.customerEmail,
// // //       required this.price,
// // //       required this.noOfPeople});

// // //   @override
// // //   _PaymentPageState createState() => _PaymentPageState();
// // // }

// // // class _PaymentPageState extends State<PaymentPage> {
// // //   String paymentOption = 'Credit Card';
// // //   late double paymentAmount;

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     paymentAmount = widget.noOfPeople * widget.price;
// // //   }

// // //   Future<void> _processPayment() async {
// // //     //double paymentAmount = widget.noOfPeople*widget.price;

// // //     // Show confirmation dialog
// // //     bool paymentConfirmed = await showDialog(
// // //           context: context,
// // //           builder: (context) {
// // //             return AlertDialog(
// // //               title: const Text('Confirm Payment'),
// // //               content: Text(
// // //                   'Proceed with $paymentOption payment of \$${paymentAmount.toStringAsFixed(2)}?'),
// // //               actions: [
// // //                 TextButton(
// // //                   onPressed: () => Navigator.pop(context, false),
// // //                   child: const Text('Cancel'),
// // //                 ),
// // //                 TextButton(
// // //                   onPressed: () => Navigator.pop(context, true),
// // //                   child: const Text('Confirm'),
// // //                 ),
// // //               ],
// // //             );
// // //           },
// // //         ) ??
// // //         false;

// // //     if (paymentConfirmed) {
// // //       // Call backend API to finalize the booking and payment transaction
// // //       await createBookingTransaction(
// // //         widget.customerEmail,
// // //         widget.packageId,
// // //         DateTime.now(),
// // //         widget.noOfPeople,
// // //         paymentAmount,
// // //       );
// // //       Navigator.pop(context); // Go back to the package details page
// // //     } else {
// // //       // Handle the payment failure or cancellation
// // //       // You can also notify the user and rollback the transaction (handled in the backend)
// // //       Navigator.pop(context);
// // //     }
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return WillPopScope(
// // //       onWillPop: () async {
// // //         // Handle the back button press (i.e., cancel the transaction and go back to the booking page)
// // //         Navigator.pop(context);
// // //         return Future.value(false); // Prevent the default back navigation
// // //       },
// // //       child: Scaffold(
// // //         appBar: AppBar(title: const Text('Payment Page')),
// // //         body: Padding(
// // //           padding: const EdgeInsets.all(16.0),
// // //           child: Column(
// // //             children: [
// // //               const Text(
// // //                 'Payment Details',
// // //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// // //               ),
// // //               const SizedBox(height: 8),
// // //               Text(
// // //                 'Number of People: ${widget.noOfPeople}',
// // //                 style: const TextStyle(fontSize: 16),
// // //               ),
// // //               const SizedBox(height: 8),
// // //               Text(
// // //                 'Payment Amount: \$${paymentAmount.toStringAsFixed(2)}',
// // //                 style: const TextStyle(fontSize: 16),
// // //               ),
// // //               const SizedBox(height: 16),
// // //               DropdownButton<String>(
// // //                 value: paymentOption,
// // //                 onChanged: (String? newValue) {
// // //                   setState(() {
// // //                     paymentOption = newValue!;
// // //                   });
// // //                 },
// // //                 items: <String>['Credit Card', 'Debit Card', 'PayPal']
// // //                     .map<DropdownMenuItem<String>>((String value) {
// // //                   return DropdownMenuItem<String>(
// // //                     value: value,
// // //                     child: Text(value),
// // //                   );
// // //                 }).toList(),
// // //               ),
// // //               ElevatedButton(
// // //                 onPressed: _processPayment,
// // //                 child: const Text('Confirm Payment'),
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // import 'package:flutter/material.dart';
// // import 'package:tourtango/api.dart';
// // import 'package:tourtango/notification.dart'; // Import your NotificationService

// // class PaymentPage extends StatefulWidget {
// //   final int packageId;
// //   final String customerEmail;
// //   final double price;
// //   final int noOfPeople;

// //   const PaymentPage(
// //       {super.key,
// //       required this.packageId,
// //       required this.customerEmail,
// //       required this.price,
// //       required this.noOfPeople});

// //   @override
// //   _PaymentPageState createState() => _PaymentPageState();
// // }

// // class _PaymentPageState extends State<PaymentPage> {
// //   String paymentOption = 'Credit Card';
// //   late double paymentAmount;

// //   // Create an instance of the NotificationService
// //   final NotificationService _notificationService = NotificationService();

// //   @override
// //   void initState() {
// //     super.initState();
// //     paymentAmount = widget.noOfPeople * widget.price;
// //   }

// //   Future<void> _processPayment() async {
// //     bool paymentConfirmed = await showDialog(
// //           context: context,
// //           builder: (context) {
// //             return AlertDialog(
// //               title: const Text('Confirm Payment'),
// //               content: Text(
// //                   'Proceed with $paymentOption payment of \$${paymentAmount.toStringAsFixed(2)}?'),
// //               actions: [
// //                 TextButton(
// //                   onPressed: () => Navigator.pop(context, false),
// //                   child: const Text('Cancel'),
// //                 ),
// //                 TextButton(
// //                   onPressed: () => Navigator.pop(context, true),
// //                   child: const Text('Confirm'),
// //                 ),
// //               ],
// //             );
// //           },
// //         ) ??
// //         false;

// //     if (paymentConfirmed) {
// //       // Call backend API to finalize the booking and payment transaction
// //       await createBookingTransaction(
// //         widget.customerEmail,
// //         widget.packageId,
// //         DateTime.now(),
// //         widget.noOfPeople,
// //         paymentAmount,
// //       );

// //       // Show a notification after successful payment
// //       _notificationService.showNotification(
// //         title: "Payment Successful",
// //         body:
// //             "Your payment of \$${paymentAmount.toStringAsFixed(2)} for ${widget.noOfPeople} people has been processed.",
// //       );

// //       Navigator.pop(context); // Go back to the package details page
// //     } else {
// //       // Handle the payment failure or cancellation
// //       Navigator.pop(context);
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return WillPopScope(
// //       onWillPop: () async {
// //         Navigator.pop(context);
// //         return Future.value(false);
// //       },
// //       child: Scaffold(
// //         appBar: AppBar(title: const Text('Payment Page')),
// //         body: Padding(
// //           padding: const EdgeInsets.all(16.0),
// //           child: Column(
// //             children: [
// //               const Text(
// //                 'Payment Details',
// //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //               ),
// //               const SizedBox(height: 8),
// //               Text(
// //                 'Number of People: ${widget.noOfPeople}',
// //                 style: const TextStyle(fontSize: 16),
// //               ),
// //               const SizedBox(height: 8),
// //               Text(
// //                 'Payment Amount: \$${paymentAmount.toStringAsFixed(2)}',
// //                 style: const TextStyle(fontSize: 16),
// //               ),
// //               const SizedBox(height: 16),
// //               DropdownButton<String>(
// //                 value: paymentOption,
// //                 onChanged: (String? newValue) {
// //                   setState(() {
// //                     paymentOption = newValue!;
// //                   });
// //                 },
// //                 items: <String>['Credit Card', 'Debit Card', 'PayPal']
// //                     .map<DropdownMenuItem<String>>((String value) {
// //                   return DropdownMenuItem<String>(
// //                     value: value,
// //                     child: Text(value),
// //                   );
// //                 }).toList(),
// //               ),
// //               ElevatedButton(
// //                 onPressed: _processPayment,
// //                 child: const Text('Confirm Payment'),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:tourtango/api.dart';
// import 'package:tourtango/notification.dart';

// class PaymentPage extends StatefulWidget {
//   final int packageId;
//   final String customerEmail;
//   final double price;
//   final int noOfPeople;

//   const PaymentPage(
//       {super.key,
//       required this.packageId,
//       required this.customerEmail,
//       required this.price,
//       required this.noOfPeople});

//   @override
//   _PaymentPageState createState() => _PaymentPageState();
// }

// class _PaymentPageState extends State<PaymentPage> {
//   String paymentOption = 'Credit Card';
//   late double paymentAmount;

//   final NotificationService _notificationService = NotificationService();

//   @override
//   void initState() {
//     super.initState();
//     paymentAmount = widget.noOfPeople * widget.price;
//   }

//   Future<void> _processPayment() async {
//     bool paymentConfirmed = await showDialog(
//           context: context,
//           builder: (context) {
//             return AlertDialog(
//               title: const Text('Confirm Payment'),
//               content: Text(
//                   'Proceed with $paymentOption payment of \$${paymentAmount.toStringAsFixed(2)}?'),
//               actions: [
//                 TextButton(
//                   onPressed: () => Navigator.pop(context, false),
//                   child: const Text('Cancel'),
//                 ),
//                 TextButton(
//                   onPressed: () => Navigator.pop(context, true),
//                   child: const Text('Confirm'),
//                 ),
//               ],
//             );
//           },
//         ) ??
//         false;

//     if (paymentConfirmed) {
//       await createBookingTransaction(
//         widget.customerEmail,
//         widget.packageId,
//         DateTime.now(),
//         widget.noOfPeople,
//         paymentAmount,
//       );

//       // Show a notification after successful payment
//       _notificationService.showNotification(
//         title: "Payment Successful",
//         body:
//             "Your payment of \$${paymentAmount.toStringAsFixed(2)} for ${widget.noOfPeople} people has been processed.",
//       );

//       Navigator.pop(context); // Go back to the package details page
//     } else {
//       Navigator.pop(context); // Cancel payment
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.pop(context);
//         return Future.value(false); // Prevent back navigation
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Payment Page'),
//           backgroundColor: Colors.teal, // Set app bar color
//         ),
//         body: SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Heading
//               const Text(
//                 'Payment Details',
//                 style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.teal),
//               ),
//               const SizedBox(height: 16),

//               // Payment details card
//               Card(
//                 elevation: 5,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     children: [
//                       Text(
//                         'Number of People: ${widget.noOfPeople}',
//                         style: const TextStyle(fontSize: 18),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         'Payment Amount: \$${paymentAmount.toStringAsFixed(2)}',
//                         style: const TextStyle(fontSize: 18),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 24),

//               // Payment option dropdown
//               Text(
//                 'Select Payment Option:',
//                 style: TextStyle(fontSize: 16, color: Colors.grey[700]),
//               ),
//               const SizedBox(height: 8),
//               DropdownButton<String>(
//                 value: paymentOption,
//                 onChanged: (String? newValue) {
//                   setState(() {
//                     paymentOption = newValue!;
//                   });
//                 },
//                 items: <String>['Credit Card', 'Debit Card', 'PayPal']
//                     .map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//               ),
//               const SizedBox(height: 32),

//               // Payment confirmation button
//               Center(
//                 child: ElevatedButton(
//                   onPressed: _processPayment,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.teal, // Button color
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 32, vertical: 16),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: const Text(
//                     'Confirm Payment',
//                     style: TextStyle(fontSize: 18, color: Colors.white),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:tourtango/api.dart';
import 'package:tourtango/notification.dart';

class PaymentPage extends StatefulWidget {
  final int packageId;
  final String customerEmail;
  final double price;
  final int noOfPeople;

  const PaymentPage(
      {super.key,
      required this.packageId,
      required this.customerEmail,
      required this.price,
      required this.noOfPeople});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String paymentOption = 'Credit Card';
  late double paymentAmount;

  final NotificationService _notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    paymentAmount = widget.noOfPeople * widget.price;
  }

  Future<void> _processPayment() async {
    bool paymentConfirmed = await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Confirm Payment'),
              content: Text(
                  'Proceed with $paymentOption payment of \$${paymentAmount.toStringAsFixed(2)}?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text('Confirm'),
                ),
              ],
            );
          },
        ) ??
        false;

    if (paymentConfirmed) {
      await createBookingTransaction(
        widget.customerEmail,
        widget.packageId,
        DateTime.now(),
        widget.noOfPeople,
        paymentAmount,
      );

      // Show a notification after successful payment
      _notificationService.showNotification(
        title: "Payment Successful",
        body:
            "Your payment of \$${paymentAmount.toStringAsFixed(2)} for ${widget.noOfPeople} people has been processed.",
      );

      Navigator.pop(context); // Go back to the package details page
    } else {
      Navigator.pop(context); // Cancel payment
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return Future.value(false); // Prevent back navigation
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Payment Page'),
          backgroundColor: Colors.teal, // Set app bar color
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Center all content vertically
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Center all content horizontally
              children: [
                // Heading
                const Text(
                  'Payment Details',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal),
                ),
                const SizedBox(height: 16),

                // Payment details card
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'Number of People: ${widget.noOfPeople}',
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Payment Amount: \$${paymentAmount.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Payment option dropdown
                Text(
                  'Select Payment Option:',
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                const SizedBox(height: 8),
                DropdownButton<String>(
                  value: paymentOption,
                  onChanged: (String? newValue) {
                    setState(() {
                      paymentOption = newValue!;
                    });
                  },
                  items: <String>['Credit Card', 'Debit Card', 'PayPal']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 32),

                // Payment confirmation button
                ElevatedButton(
                  onPressed: _processPayment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal, // Button color
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Confirm Payment',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

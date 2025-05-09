import 'package:flutter/material.dart';
import 'package:tourtango/api.dart';
import 'package:tourtango/notification.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart' hide Card;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

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
  String paymentOption="Credit Card";
  late double paymentAmount;
  Map<String, dynamic>? paymentIntent;

  final NotificationService _notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    paymentAmount = widget.noOfPeople * widget.price;
  }

  Future<void> _processPayment() async {
    try {
      // Create a payment intent on the server
      paymentIntent = await createPaymentIntent(paymentAmount.toString(), 'USD');

      // Initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          merchantDisplayName: 'TourTango',
        ),
      );

      // Display the payment sheet
      await Stripe.instance.presentPaymentSheet();

      // Show success notification
      _showPaymentSuccessDialog();
      await createBookingTransaction(widget.customerEmail, widget.packageId,
          DateTime.now(), widget.noOfPeople, paymentAmount, paymentOption);

      _notificationService.showNotification(
        title: "Payment Successful",
        body:
            "Your payment of \$${paymentAmount.toStringAsFixed(2)} for ${widget.noOfPeople} people has been processed.",
      );
      Navigator.pop(context);

    } catch (e) {
      _showPaymentErrorDialog();
      Navigator.pop(context);
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent(String amount, String currency) async {
    try {
      final body = {
        'amount': _calculateStripeAmount(amount),
        'currency': currency,
      };

      final response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['STRIPE_API_KEY']}',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      return json.decode(response.body);
    } catch (err) {
      throw Exception('Failed to create payment intent: $err');
    }
  }

  String _calculateStripeAmount(String amount) {
    final intAmount = (double.parse(amount) * 100).toInt();
    return intAmount.toString();
  }

  void _showPaymentSuccessDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Payment Successful'),
        content: Text(
          'Your payment of \$${paymentAmount.toStringAsFixed(2)} for ${widget.noOfPeople} people has been processed.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );

    Navigator.pop(context);
    Navigator.pop(context);
    
  }

  void _showPaymentErrorDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Payment Failed'),
        content: const Text('Something went wrong while processing your payment.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
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
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Payment Details',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
              const SizedBox(height: 32),
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
                   items: <String>['Credit Card', 'Debit Card']
                       .map<DropdownMenuItem<String>>((String value) {
                     return DropdownMenuItem<String>(
                       value: value,
                       child: Text(value),
                     );
                   }).toList(),
                 ),
                 const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _processPayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
//       await createBookingTransaction(widget.customerEmail, widget.packageId,
//           DateTime.now(), widget.noOfPeople, paymentAmount, paymentOption);

//       _notificationService.showNotification(
//         title: "Payment Successful",
//         body:
//             "Your payment of \$${paymentAmount.toStringAsFixed(2)} for ${widget.noOfPeople} people has been processed.",
//       );

//       Navigator.pop(context);
//     } else {
//       Navigator.pop(context);
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
//           backgroundColor: Colors.teal,
//         ),
//         body: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 // Heading
//                 const Text(
//                   'Payment Details',
//                   style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.teal),
//                 ),
//                 const SizedBox(height: 16),

//                 // Payment details card
//                 Card(
//                   elevation: 5,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       children: [
//                         Text(
//                           'Number of People: ${widget.noOfPeople}',
//                           style: const TextStyle(fontSize: 18),
//                         ),
//                         const SizedBox(height: 8),
//                         Text(
//                           'Payment Amount: \$${paymentAmount.toStringAsFixed(2)}',
//                           style: const TextStyle(fontSize: 18),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 24),

//                 Text(
//                   'Select Payment Option:',
//                   style: TextStyle(fontSize: 16, color: Colors.grey[700]),
//                 ),
//                 const SizedBox(height: 8),
//                 DropdownButton<String>(
//                   value: paymentOption,
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       paymentOption = newValue!;
//                     });
//                   },
//                   items: <String>['Credit Card', 'Debit Card', 'PayPal']
//                       .map<DropdownMenuItem<String>>((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                 ),
//                 const SizedBox(height: 32),

//                 ElevatedButton(
//                   onPressed: _processPayment,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.teal,
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
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:tourtango/api.dart';

class PaymentPage extends StatefulWidget {
  final int packageId;
  final String customerEmail;
  final double price;
  final int noOfPeople;

  PaymentPage({required this.packageId, required this.customerEmail, required this.price, required this.noOfPeople});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String paymentOption = 'Credit Card';
  late double paymentAmount;

  @override
  void initState(){
    super.initState();
    paymentAmount = widget.noOfPeople*widget.price;
  }

  Future<void> _processPayment() async {
    //double paymentAmount = widget.noOfPeople*widget.price;

    // Show confirmation dialog
    bool paymentConfirmed = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm Payment'),
          content: Text('Proceed with $paymentOption payment of \$${paymentAmount.toStringAsFixed(2)}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text('Confirm'),
            ),
          ],
        );
      },
    ) ?? false;

    if (paymentConfirmed) {
      // Call backend API to finalize the booking and payment transaction
      await createBookingTransaction(
        widget.customerEmail,
        widget.packageId,
        DateTime.now(),
        widget.noOfPeople,
        paymentAmount,
        paymentOption
      );
      Navigator.pop(context); // Go back to the package details page
    } else {
      // Handle the payment failure or cancellation
      // You can also notify the user and rollback the transaction (handled in the backend)
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle the back button press (i.e., cancel the transaction and go back to the booking page)
        Navigator.pop(context);
        return Future.value(false); // Prevent the default back navigation
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Payment Page')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                  'Payment Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
              SizedBox(height: 8),
              Text(
                'Number of People: ${widget.noOfPeople}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'Payment Amount: \$${paymentAmount.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
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
              ElevatedButton(
                onPressed: _processPayment,
                child: Text('Confirm Payment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tourtango/api.dart';
import 'payment_page.dart';

class BookingPage extends StatefulWidget {
  final int packageId;
  final String customerEmail;
  final double price;

  BookingPage({required this.packageId, required this.customerEmail, required this.price});

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final TextEditingController _noOfPeopleController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  Future<void> _createBooking() async {
    int people = int.parse(_noOfPeopleController.text);
    // Navigate to the payment page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentPage(
          packageId: widget.packageId,
          customerEmail: widget.customerEmail,
          price:widget.price,
          noOfPeople: people
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle the back button press (i.e., navigate to the package details page)
        Navigator.pop(context);
        return Future.value(false); // Prevent the default back navigation
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Booking Page')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _noOfPeopleController,
                decoration: InputDecoration(labelText: 'No of People'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              ElevatedButton(
                onPressed: _createBooking,
                child: Text('Proceed to Payment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

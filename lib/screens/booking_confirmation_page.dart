import 'package:flutter/material.dart';

class BookingConfirmationPage extends StatelessWidget {
  final String name;
  final String email;
  final String phone;
  final String packageName;

  BookingConfirmationPage({
    required this.name,
    required this.email,
    required this.phone,
    required this.packageName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Confirmation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Booking Confirmed!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('Name: $name'),
            Text('Email: $email'),
            Text('Phone: $phone'),
            Text('Package: $packageName'),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Navigate back to home
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: Text('Go to Home'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

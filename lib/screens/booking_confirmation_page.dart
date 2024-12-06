import 'package:flutter/material.dart';

class BookingConfirmationPage extends StatelessWidget {
  final String name;
  final String email;
  final String phone;
  final String packageName;

  const BookingConfirmationPage({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
    required this.packageName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Confirmation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Booking Confirmed!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text('Name: $name'),
            Text('Email: $email'),
            Text('Phone: $phone'),
            Text('Package: $packageName'),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // Navigate back to home
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Go to Home'),
            ),
          ],
        ),
      ),
    );
  }
}

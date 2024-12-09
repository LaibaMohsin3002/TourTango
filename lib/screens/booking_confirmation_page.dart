import 'package:flutter/material.dart';
import 'package:tourtango/notification.dart';
import 'payment_page.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

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
          packageId: packageId,
          customerEmail: email,
          price: price,
          noOfPeople: people,
        ),
      ),
    );
  }

  Future<void> _generatePDF() async {
    final pdf = pw.Document();

    pdf.addPage(pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          children: [
            pw.Text('Booking Details',
                style:
                    pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 20),
            pw.Text('Name: $name'),
            pw.Text('Email: $email'),
            pw.Text('Phone: $phone'),
            pw.Text('Tour Company: $tourCompany'),
            pw.Text('Duration: $duration'),
            pw.Text('Price: \$${price.toStringAsFixed(2)}'),
            pw.Text('Package: $packageId'),
            pw.Text('Booking Date: $bookingDate'),
            pw.Text('Number of People: $numberOfPeople'),
          ],
        );
      },
    ));

    // Get the directory to save the file
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/booking_details.pdf');

    // Save the PDF to the file
    await file.writeAsBytes(await pdf.save());

    // Notify user that the PDF is ready to be downloaded
    print("PDF saved to: ${file.path}");
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
      backgroundColor: const Color.fromARGB(255, 238, 242, 239),
      appBar: AppBar(
        title: const Text('Booking Confirmation'),
        backgroundColor: const Color.fromARGB(255, 100, 131, 156),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
              _buildInfoCard('Price', '\$${price.toStringAsFixed(2)}'),
              const SizedBox(height: 16),
              _buildInfoCard('Package', packageId.toString()),
              const SizedBox(height: 16),
              _buildInfoCard('Booking Date', bookingDate),
              const SizedBox(height: 16),
              _buildInfoCard('Number of People', numberOfPeople),
              const SizedBox(height: 32),
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
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _generatePDF,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 176, 174, 196),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text('Download Booking Details'),
              ),
            ],
          ),
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

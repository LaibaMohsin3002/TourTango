import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tourtango/notification.dart';
import 'booking_confirmation_page.dart';
import 'package:tourtango/api.dart';

class BookingFormPage extends StatefulWidget {
  final int packageId;
  final String customerEmail;
  final double price;

  const BookingFormPage({
    Key? key,
    required this.packageId,
    required this.customerEmail,
    required this.price,
  }) : super(key: key);

  @override
  State<BookingFormPage> createState() => _BookingFormPageState();
}

class _BookingFormPageState extends State<BookingFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _numberOfPeopleController = TextEditingController();
  final NotificationService notificationService = NotificationService();
  final String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String tourCompany = '';
  String duration = '';

  @override
  void initState() {
    super.initState();
    fetchPackageDetails();
  }

  Future<void> fetchPackageDetails() async {
    try {
      final packageDetails = await getPackageDetails(widget.packageId);
      final String? startDateString = packageDetails['start_date'];
      final String? endDateString = packageDetails['end_date'];

      if (startDateString != null && endDateString != null) {
        try {
          final startDate = DateTime.parse(startDateString);
          final endDate = DateTime.parse(endDateString);

          setState(() {
            tourCompany = packageDetails['companyName'];
            duration = '${endDate.difference(startDate).inDays} days';
          });
        } catch (dateError) {
          setState(() {
            tourCompany = packageDetails['companyName'] ?? 'Unknown';
            duration = 'Invalid date format';
          });
        }
      } else {
        setState(() {
          tourCompany = packageDetails['companyName'] ?? 'Unknown';
          duration = 'Dates not available';
        });
      }
    } catch (error) {
      setState(() {
        tourCompany = 'Unknown';
        duration = 'Error fetching details';
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _numberOfPeopleController.dispose();
    super.dispose();
  }

  Widget _buildInfoDisplay(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Text('Book Package ${widget.packageId}'),
        backgroundColor: const Color.fromARGB(255, 100, 131, 156),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildInfoDisplay('Tour Company',
                    tourCompany.isNotEmpty ? tourCompany : 'Unknown Company'),
                _buildInfoDisplay('Package ID', widget.packageId.toString()),
                _buildInfoDisplay('Duration', duration),
                _buildInfoDisplay('Customer Email', widget.customerEmail),
                _buildInfoDisplay(
                    'Price', '\$${widget.price.toStringAsFixed(2)}'),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 16.0),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your name' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 16.0),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your phone number' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _numberOfPeopleController,
                  decoration: InputDecoration(
                    labelText: 'Number of People',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 16.0),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty
                      ? 'Please enter the number of people'
                      : null,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      notificationService.showNotification(
                        id: 1,
                        title: 'Booking Confirmed',
                        body:
                            'Your booking for package ID ${widget.packageId} has been confirmed.',
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingConfirmationPage(
                            name: _nameController.text,
                            email: widget.customerEmail,
                            phone: _phoneController.text,
                            packageId: widget.packageId,
                            tourCompany: tourCompany,
                            duration: duration,
                            price: widget.price,
                            bookingDate: currentDate,
                            numberOfPeople: _numberOfPeopleController.text,
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 176, 174, 196),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text('Confirm Booking'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

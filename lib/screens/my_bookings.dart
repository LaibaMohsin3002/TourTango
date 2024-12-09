import 'package:flutter/material.dart';
import 'package:tourtango/api.dart';

class BookingsPage extends StatefulWidget {
  final String customerEmail;

  BookingsPage({required this.customerEmail});

  @override
  _BookingsPageState createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {
  late Future<List<dynamic>> _bookings;

  @override
  void initState() {
    super.initState();
    _bookings = fetchBookings(widget.customerEmail);
  }


  void _cancelBooking(int bookingID) async {
    try {
      await deleteBooking(bookingID);
      setState(() {
        _bookings = fetchBookings(widget.customerEmail); // Refetch bookings
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to cancel booking')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookings'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _bookings,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error fetching bookings'));
          }

          if (snapshot.data == null || snapshot.data!.isEmpty) {
            return Center(child: Text('No bookings found'));
          }

          final bookings = snapshot.data!;

          return ListView.builder(
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              final booking = bookings[index];
              return ListTile(
                title: Text('Booking ID: ${booking['BookingID']}'),
                subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Booking Date: ${booking['BookingDate']}'),
                        Text('Confirmation Status: ${booking['confirmationStatus']}'),
                        Text('Number of people: ${booking['noOfPeople']}'),
                        Text('Amount paid: ${booking['amount']}'),
                      ],
                    ),
                trailing: ElevatedButton(
                  onPressed: () => _cancelBooking(booking['BookingID']),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal, // Button color
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'CANCEL BOOKING',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

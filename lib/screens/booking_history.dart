import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date comparison
import 'package:tourtango/api.dart';
import 'review_detail_page.dart'; // Assuming you have this page implemented

class BookingHistoryPage extends StatefulWidget {
  final String customerEmail;

  const BookingHistoryPage({super.key, required this.customerEmail});

  @override
  _BookingHistoryPageState createState() => _BookingHistoryPageState();
}

class _BookingHistoryPageState extends State<BookingHistoryPage> {
  late Future<List<dynamic>> _historyFuture;

  @override
  void initState() {
    super.initState();
    _historyFuture = fetchCustomerHistory(widget.customerEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking History'),
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _historyFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(fontSize: 16, color: Colors.red),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No booking history found.',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          final history = snapshot.data!;
          return ListView.builder(
            itemCount: history.length,
            itemBuilder: (context, index) {
              final historyItem = history[index];

              // Extract details
              final bookingID = historyItem['booking_id'];
              final bookingDate = historyItem['booking_date'];
              final totalAmount = historyItem['total_amount'];
              final operation = historyItem['operation'];
              final timestamp = historyItem['action_timestamp'];
              final packageName = historyItem['packageName'];
              final paymentMode = historyItem['payment_mode'];
              final startDate = DateTime.parse(historyItem['start_date']);
              final endDate = DateTime.parse(historyItem['end_date']);
              final noOfPeople = historyItem['noOfPeople'];
              final company = historyItem['tourCompany'];

              final duration = endDate.difference(startDate).inDays;

              // Check if the package is reviewable
              final isReviewable = DateTime.now().isAfter(endDate);

              return Card(
                margin: const EdgeInsets.all(10),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Booking ID: $bookingID',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Package Name: $packageName',
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Payment ID: $company',
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Booking Date: $bookingDate',
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Status: $operation',
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Total Amount: \$${totalAmount.toStringAsFixed(2)}',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.green),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Number of people booked for: $noOfPeople',
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Number of days for tour: $duration',
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'End Date: ${DateFormat('yyyy-MM-dd').format(endDate)}',
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: isReviewable
                            ? () {
                                // Navigate to ReviewDetailPage with bookingID
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ReviewDetailPage(bookingID: bookingID),
                                  ),
                                );
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isReviewable
                              ? Colors.blue
                              : Colors.grey, // Disable button if not reviewable
                        ),
                        child: const Text('Leave Review'),
                      ),
                    ],
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

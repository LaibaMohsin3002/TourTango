import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date comparison
import 'package:tourtango/api.dart';
import 'review_detail_page.dart'; // Assuming you have this page implemented

class BookingHistoryPage extends StatefulWidget {
  final String customerEmail;

  BookingHistoryPage({required this.customerEmail});

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
        title: Text('Booking History'),
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _historyFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
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
              final status = historyItem['booking_status'];
              final totalAmount = historyItem['total_amount'];
              final operation = historyItem['operation'];
              final timestamp = historyItem['action_timestamp'];
              final packageName = historyItem['packageName'];
              final paymentID = historyItem['payment_id'];
              final endDate = DateTime.parse(historyItem['end_date']);

              // Check if the package is reviewable
              final isReviewable = DateTime.now().isAfter(endDate);

              return Card(
                margin: EdgeInsets.all(10),
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Booking ID: $bookingID',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Package Name: $packageName',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Payment ID: $paymentID',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Booking Date: $bookingDate',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Status: $status',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Total Amount: \$${totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 14, color: Colors.green),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Operation: $operation',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Action Timestamp: $timestamp',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'End Date: ${DateFormat('yyyy-MM-dd').format(endDate)}',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 15),
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
                        child: Text('Leave Review'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isReviewable
                              ? Colors.blue
                              : Colors.grey, // Disable button if not reviewable
                        ),
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

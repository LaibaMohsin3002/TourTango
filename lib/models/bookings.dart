class Booking {
  final int bookingID;
  final DateTime bookingDate;
  final String confirmationStatus;
  final int noOfPeople;
  final int customerID;
  final int packageID;
  final int paymentID;

  Booking({
    required this.bookingID,
    required this.bookingDate,
    required this.confirmationStatus,
    required this.noOfPeople,
    required this.customerID,
    required this.packageID,
    required this.paymentID,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      bookingID: json['BookingID'],
      bookingDate: json['BookingDate'],
      confirmationStatus: json['confirmationStatus'],
      noOfPeople: json['noOfPeople'],
      customerID: json['customerID'],
      packageID: json['packageID'],
      paymentID: json['paymentID'],
    );
  }
}

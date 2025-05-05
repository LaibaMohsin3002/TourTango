class Payment {
  final int paymentID;
  final double paymentAmount;
  final DateTime paymentDate;
  final String paymentMode;

  Payment({
    required this.paymentID,
    required this.paymentAmount,
    required this.paymentDate,
    required this.paymentMode,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      paymentID: json['paymentID'],
      paymentAmount: json['amount'],
      paymentDate: json['paymentDate'],
      paymentMode: json['payment_mode'],
    );
  }
}

class Flight {
  final int flightID;
  final DateTime departureTime;
  final DateTime arrivalTime;
  final String flightCompany;

  Flight({
    required this.flightID,
    required this.departureTime,
    required this.arrivalTime,
    required this.flightCompany,
  });

  factory Flight.fromJson(Map<String, dynamic> json) {
    return Flight(
      flightID: json['flightID'],
      departureTime: json['departureTime'],
      arrivalTime: json['arrivalTime'],
      flightCompany: json['FlightCompany'],
    );
  }
}

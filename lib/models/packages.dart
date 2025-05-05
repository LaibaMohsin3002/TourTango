class Package {
  final int packageID;
  final String packageName;
  final double price;
  final String availability;
  final String description;
  final String startDate;
  final String endDate;
  final String? vehicleType;
  final String? driverName;
  final String? pickupLocation;
  final String? guideName;
  final String? guideAvailability;
  final String? flightCompany;
  final String? departureTime;
  final String? arrivalTime;
  final String? hotelName;
  final String country;
  final String imageUrl;
  final String specialOffers;
  //final int duration; // Duration in days

  Package({
    required this.packageID,
    required this.packageName,
    required this.price,
    required this.availability,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.vehicleType,
    required this.driverName,
    required this.pickupLocation,
    required this.guideName,
    required this.guideAvailability,
    required this.flightCompany,
    required this.departureTime,
    required this.arrivalTime,
    required this.hotelName,
    required this.country,
    required this.imageUrl,
    required this.specialOffers,
    //  required this.duration, // Duration passed directly
  });

  factory Package.fromJson(Map<String, dynamic> json) {
    return Package(
      packageID: json['packageID'],
      packageName: json['packageName'],
      price: (json['price'] is int)
          ? (json['price'] as int).toDouble()
          : json['price'] as double,
      availability: json['availability'],
      description: json['description'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      vehicleType: json['vehicleType'],
      driverName: json['driverName'],
      pickupLocation: json['pickupLocation'],
      guideName: json['guideName'],
      guideAvailability: json['guideAvailability'],
      flightCompany: json['FlightCompany'],
      departureTime: json['departureTime'],
      arrivalTime: json['arrivalTime'],
      hotelName: json['hotelName'],
      country: json['country'],
      imageUrl: json['imageUrl'],
      specialOffers: json['specialOffers'] ?? '',
    );
  }
}

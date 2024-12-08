// models/package.dart

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
  final String? checkInDate;
  final String? checkOutDate;
  final String country;
  final String imageUrl;

  Package(
      {required this.packageID,
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
      required this.checkInDate,
      required this.checkOutDate,
      required this.country,
      required this.imageUrl});

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
      flightCompany: json['flightCompany'],
      departureTime: json['departureTime'],
      arrivalTime: json['arrivalTime'],
      hotelName: json['hotelName'],
      checkInDate: json['checkInDate'],
      checkOutDate: json['checkOutDate'],
      country: json['country'],
      imageUrl: json['imageUrl'],
    );
  }
}

class Transport {
  final int transportID;
  final String vehicleType;
  final String pickupLocation;
  final String driverName;
  final int companyID;

  Transport({
    required this.transportID,
    required this.vehicleType,
    required this.pickupLocation,
    required this.driverName,
    required this.companyID
  });

  factory Transport.fromJson(Map<String, dynamic> json) {
    return Transport(
      transportID: json['transportID'],
      vehicleType: json['vehicleType'],
      pickupLocation: json['pickupLocation'],
      driverName: json['driverName'],
      companyID: json['companyID']
    );
  }
}

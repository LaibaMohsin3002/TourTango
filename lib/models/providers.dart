class Provider {
  final int companyID;
  final String companyName;
  final String email;
  final String website;
  final int plotNo;
  final String streetAddress;
  final String city;
  final String country;
  final String password;

  Provider({
    required this.companyID,
    required this.companyName,
    required this.email,
    required this.website,
    required this.plotNo,
    required this.streetAddress,
    required this.city,
    required this.country,
    required this.password,
  });

  factory Provider.fromJson(Map<String, dynamic> json) {
    return Provider(
      companyID: json['companyID'],
      companyName: json['companyName'],
      email: json['email'],
      website: json['website'],
      plotNo: json['plotNo'],
      streetAddress: json['street_address'],
      city: json['city'],
      country: json['country'],
      password: json['password'],
    );
  }
}

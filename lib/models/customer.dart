class Customer {
  final int customerID;
  final String name;
  final String email;
  final String password;

  Customer({
    required this.customerID,
    required this.name,
    required this.email,
    required this.password,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      customerID: json['customerID'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
    );
  }
}

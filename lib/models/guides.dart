class Guide {
  final int guideID;
  final String guideName;
  final String guideAvailability;
  final int companyID;

  Guide({
    required this.guideID,
    required this.guideName,
    required this.guideAvailability,
    required this.companyID,
  });

  factory Guide.fromJson(Map<String, dynamic> json) {
    return Guide(
      guideID: json['guideID'],
      guideName: json['guideName'],
      guideAvailability: json['guideAvailability'],
      companyID: json['companyID'],
    );
  }
}

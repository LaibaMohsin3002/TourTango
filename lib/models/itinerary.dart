class Itinerary {
  final int itineraryID;
  final DateTime itineraryDate;
  final String timeOfDay;
  final String activity;
  final String description;
  final String city;

  Itinerary({
    required this.itineraryID,
    required this.itineraryDate,
    required this.timeOfDay,
    required this.activity,
    required this.description,
    required this.city,
  });

  factory Itinerary.fromJson(Map<String, dynamic> json) {
    return Itinerary(
      itineraryID: json['itineraryID'],
      itineraryDate: json['date'],
      timeOfDay: json['time_of_day'],
      activity: json['activity_name'],
      description: json['description'],
      city: json['city'],
    );
  }
}

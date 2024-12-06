// models/package.dart
class Package {
  final String name;
  final String description;
  final String imageUrl;

  Package(
      {required this.name, required this.description, required this.imageUrl});

  factory Package.fromJson(Map<String, dynamic> json) {
    return Package(
      name: json['name'],
      description: json['description'],
      imageUrl: json['image_url'],
    );
  }
}

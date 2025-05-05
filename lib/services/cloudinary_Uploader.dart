import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CloudinaryUploader {
  final String cloudName = 'dbrnniorg';

  Future<String?> uploadImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);

        // Create a multipart request for image upload
        var request = http.MultipartRequest(
          'POST',
          Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/upload'),
        );

        // Add required fields
        request.fields['upload_preset'] = 'tourtango';
        request.fields['timestamp'] = DateTime.now().millisecondsSinceEpoch.toString();
        request.files.add(await http.MultipartFile.fromPath('file', imageFile.path));

        // Send the request
        var response = await request.send();

        if (response.statusCode == 200) {
          var responseData = await http.Response.fromStream(response);
          var jsonResponse = jsonDecode(responseData.body);
          String? imageUrl = jsonResponse['url'];

          print("Image uploaded successfully: $imageUrl");
          return imageUrl;
        } else {
          print("Failed to upload image. Status code: ${response.statusCode}");
          return null;
        }
      } else {
        print("No image selected.");
        return null;
      }
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }
}

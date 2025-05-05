import 'package:flutter/material.dart';
import 'package:tourtango/api.dart';

class ProfilePage extends StatefulWidget {
  final String companyEmail;
  const ProfilePage({super.key, required this.companyEmail});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEditing = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController plotNoController = TextEditingController();
  TextEditingController streetAddressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  String name = "";
  String email = "";
  String website = "";
  String plotNo = "";
  String address = "";
  String city = "";
  String country = "";

  @override
  void initState() {
    super.initState();
    _fetchProfileData();
  }

  Future<void> _fetchProfileData() async {
    try {
      var profile = await fetchProviderProfile(widget.companyEmail);
      setState(() {
        name = profile['name'] ?? '';
        email = profile['email'] ?? '';
        website = profile['website'] ?? "Add website";
        plotNo = profile['plotNo'] ?? "Add plot number";
        address = profile['street_address'] ?? "Add street address number";
        city = profile['city'] ?? "Add city";
        country = profile['country'] ?? "Add country";
      });
    } catch (e) {
      print("Error fetching profile: $e");
    }
  }

  // Save updated profile data to the database
  Future<void> _updateProfileData() async {
    try {
      await updateProviderProfile(
        nameController.text,
        emailController.text,
        websiteController.text,
        plotNoController.text,
        streetAddressController.text,
        cityController.text,
        countryController.text,
        widget.companyEmail,
      );
      setState(() {
        name = nameController.text;
        email = emailController.text;
        website = websiteController.text;
        plotNo = plotNoController.text;
        address = streetAddressController.text;
        city = cityController.text;
        country = countryController.text;
        isEditing = false;
      });

      Navigator.pop(context);
    } catch (e) {
      print("Error updating profile: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(229, 253, 253, 253),
      appBar: AppBar(
        title: const Text("Profile"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color.fromARGB(255, 206, 176, 186),
      ),
      body: SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          top: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundColor: const Color.fromARGB(10, 233, 30, 98),
              child: const Icon(Icons.account_circle,
                  size: 80, color: Colors.white),
            ),
            const SizedBox(height: 16),

            _buildProfileField(
              label: "Company Name",
              value: name,
              icon: Icons.house,
              isEditable: isEditing,
              controller: nameController,
            ),
            const SizedBox(height: 16),

            _buildProfileField(
              label: "Email",
              value: email,
              icon: Icons.email,
              isEditable: isEditing,
              controller: emailController,
            ),
            const SizedBox(height: 16),

            _buildProfileField(
              label: "Website",
              value: website,
              icon: Icons.web,
              isEditable: isEditing,
              controller: websiteController,
            ),
            const SizedBox(height: 16),

            _buildProfileField(
              label: "Plot No",
              value: plotNo,
              icon: Icons.phone,
              isEditable: isEditing,
              controller: plotNoController,
            ),
            const SizedBox(height: 16),

            _buildProfileField(
              label: "Street Address",
              value: address,
              icon: Icons.place,
              isEditable: isEditing,
              controller: streetAddressController,
            ),
            const SizedBox(height: 16),

            _buildProfileField(
              label: "City",
              value: city,
              icon: Icons.place,
              isEditable: isEditing,
              controller: cityController,
            ),
            const SizedBox(height: 16),

            _buildProfileField(
              label: "Country",
              value: country,
              icon: Icons.place,
              isEditable: isEditing,
              controller: countryController,
            ),
            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: () {
                if (isEditing) {
                  _updateProfileData();
                } else {
                  setState(() {
                    isEditing = true;
                    nameController.text = name;
                    emailController.text = email;
                    websiteController.text = website;
                    plotNoController.text = plotNo;
                    streetAddressController.text = address;
                    cityController.text = city;
                    countryController.text = country;
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 206, 176, 186),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: Text(
                isEditing ? "Save Changes" : "Update Information",
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    ),

    );
  }

  Widget _buildProfileField({
    required String label,
    required String value,
    required IconData icon,
    bool isEditable = false,
    TextEditingController? controller,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: isEditable && controller != null
          ? TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: label,
                prefixIcon:
                    Icon(icon, color: const Color.fromARGB(255, 100, 131, 156)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            )
          : Row(
              children: [
                Icon(icon, color: const Color.fromARGB(255, 100, 131, 156)),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    "$label: $value",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 20, 20, 20),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
    );
  }
}

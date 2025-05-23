import 'package:flutter/material.dart';
import 'package:tourtango/api.dart';

class ProfilePage extends StatefulWidget {
  final String customerEmail;
  const ProfilePage({super.key, required this.customerEmail});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEditing = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController primaryPhoneController = TextEditingController();
  final TextEditingController secondaryPhoneController = TextEditingController();

  String name = "";
  String email = "";
  String primaryPhone = "";
  String secondaryPhone = "";

  @override
  void initState() {
    super.initState();
    _fetchProfileData();
  }

  Future<void> _fetchProfileData() async {
    try {
      final profile = await fetchProfile(widget.customerEmail);
      setState(() {
        name = profile['name'] ?? '';
        email = profile['email'] ?? '';
        primaryPhone = profile['primaryPhone'] ?? "Add Primary Phone Number";
        secondaryPhone = profile['secondaryPhone'] ?? "Add Secondary Phone Number";
      });
    } catch (e) {
      print("Error fetching profile: $e");
    }
  }

  Future<void> _updateProfileData() async {
    try {
      final sanitizedPrimaryPhone = sanitizePhone(primaryPhoneController.text);
      final sanitizedSecondaryPhone = sanitizePhone(secondaryPhoneController.text);

      if (phoneValidator(sanitizedPrimaryPhone) != null ||
          phoneValidator(sanitizedSecondaryPhone) != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter valid phone numbers (at least 11 digits).")),
        );
        return;
      }

      await updateProfile(
        nameController.text,
        emailController.text,
        sanitizedPrimaryPhone,
        sanitizedSecondaryPhone,
        widget.customerEmail,
      );

      setState(() {
        name = nameController.text;
        email = emailController.text;
        primaryPhone = sanitizedPrimaryPhone;
        secondaryPhone = sanitizedSecondaryPhone;
        isEditing = false;
      });

      Navigator.pop(context);
    } catch (e) {
      print("Error updating profile: $e");
    }
  }

  String? phoneValidator(String? value) {
    final cleaned = value?.replaceAll(RegExp(r'\D'), '') ?? '';
    if (cleaned.length < 11) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  String sanitizePhone(String value) {
    return value.replaceAll(RegExp(r'\D'), '');
  }

  String formatPhone(String value) {
    final digits = sanitizePhone(value);
    if (digits.length == 11) {
      return "${digits.substring(0, 4)}-${digits.substring(4, 7)}-${digits.substring(7)}";
    } else if (digits.length == 10) {
      return "${digits.substring(0, 3)}-${digits.substring(3, 6)}-${digits.substring(6)}";
    } else {
      return value;
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
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: const Color.fromARGB(255, 206, 176, 186),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundColor: Color.fromARGB(10, 233, 30, 98),
                child: Icon(Icons.account_circle, size: 80, color: Colors.white),
              ),
              const SizedBox(height: 16),

              _buildProfileField(
                label: "Name",
                value: name,
                icon: Icons.person,
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
                label: "Primary Phone",
                value: formatPhone(primaryPhone),
                icon: Icons.phone,
                isEditable: isEditing,
                controller: primaryPhoneController,
              ),
              const SizedBox(height: 16),

              _buildProfileField(
                label: "Secondary Phone",
                value: formatPhone(secondaryPhone),
                icon: Icons.phone,
                isEditable: isEditing,
                controller: secondaryPhoneController,
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
                      primaryPhoneController.text = sanitizePhone(primaryPhone);
                      secondaryPhoneController.text = sanitizePhone(secondaryPhone);
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
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: label,
                prefixIcon: Icon(icon, color: const Color.fromARGB(255, 100, 131, 156)),
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

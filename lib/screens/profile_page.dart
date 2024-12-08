// import 'package:flutter/material.dart';

// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Profile'),
//       ),
//       body: const Center(
//         child: Text('Profile information goes here'),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEditing = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
          229, 253, 253, 253), // Set a pastel green background
      body: Center(
        // Center the entire content
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Center the content vertically
            crossAxisAlignment:
                CrossAxisAlignment.center, // Center the content horizontally
            children: [
              // Profile Image Section
              const CircleAvatar(
                radius: 50,
                backgroundColor: Color.fromARGB(10, 233, 30, 98),
                child:
                    Icon(Icons.account_circle, size: 80, color: Colors.white),
              ),
              const SizedBox(height: 16),
              // Name Field
              _buildProfileField(
                label: "Name",
                value: "John Doe",
                icon: Icons.person,
                isReadOnly: true,
              ),
              const SizedBox(height: 16),

              // Email Field
              _buildProfileField(
                label: "Email",
                value: "johndoe@example.com",
                icon: Icons.email,
                isReadOnly: true,
              ),
              const SizedBox(height: 16),

              // Phone Number Field
              _buildProfileField(
                label: "Phone Number",
                value: "+1234567890",
                icon: Icons.phone,
                isReadOnly: true,
              ),
              const SizedBox(height: 16),

              // Update Info Button
              if (!isEditing)
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isEditing = true; // Enable editing mode
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(
                        255, 206, 176, 186), // Pastel pink color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    minimumSize: const Size(double.infinity,
                        50), // Make button same width as fields
                  ),
                  child: const Text(
                    "Update Information",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              // Editable Fields and Confirm Update Button
              if (isEditing) ...[
                const SizedBox(height: 16),
                _buildEditableField(
                  label: "New Name",
                  controller: nameController,
                  icon: Icons.person,
                ),
                const SizedBox(height: 16),
                _buildEditableField(
                  label: "New Email",
                  controller: emailController,
                  icon: Icons.email,
                ),
                const SizedBox(height: 16),
                _buildEditableField(
                  label: "New Phone Number",
                  controller: phoneController,
                  icon: Icons.phone,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isEditing = false; // Confirm changes
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(
                        255, 206, 176, 186), // Pastel pink color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    minimumSize: const Size(double.infinity,
                        50), // Make button same width as fields
                  ),
                  child: const Text(
                    "Confirm Update",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to create profile fields with label, value, and an icon
  Widget _buildProfileField({
    required String label,
    required String value,
    required IconData icon,
    required bool isReadOnly,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20), // Rounded corners for fields
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color.fromARGB(
                255, 100, 131, 156), // Light pastel color for the icon
          ),
          const SizedBox(width: 16),
          Text(
            "$label: $value",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(
                  255, 20, 20, 20), // Darker text for readability
            ),
          ),
        ],
      ),
    );
  }

  // Helper method for editable fields when in editing mode
  Widget _buildEditableField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20), // Rounded corners for fields
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon:
              Icon(icon, color: const Color.fromARGB(255, 100, 131, 156)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}

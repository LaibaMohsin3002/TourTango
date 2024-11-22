// import 'package:flutter/material.dart';
// import 'customer_home_page.dart';

// class CustomerLoginPage extends StatefulWidget {
//   @override
//   _CustomerLoginPageState createState() => _CustomerLoginPageState();
// }

// class _CustomerLoginPageState extends State<CustomerLoginPage> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();

//   // Key for the Form widget
//   final _formKey = GlobalKey<FormState>();

//   // Email regex pattern
//   String? _emailValidator(String? email) {
//     if (email == null || email.isEmpty) {
//       return 'Please enter an email';
//     }
//     final emailRegex =
//         RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
//     if (!emailRegex.hasMatch(email)) {
//       return 'Please enter a valid email address';
//     }
//     return null;
//   }

//   // Password validator
//   String? _passwordValidator(String? password) {
//     if (password == null || password.isEmpty) {
//       return 'Please enter a password';
//     }
//     if (password.length < 6) {
//       return 'Password must be at least 6 characters long';
//     }
//     return null;
//   }

//   void _login() {
//     if (_formKey.currentState?.validate() ?? false) {
//       // If the form is valid, proceed with login logic
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => CustomerHomePage()),
//       );
//     } else {
//       // If the form is invalid, show an error message (optional)
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please fix the errors before submitting')),
//       );
//     }
//   }

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey, // Attach the form key
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Customer Login',
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 40),
//                 TextFormField(
//                   controller: _emailController,
//                   decoration: InputDecoration(
//                     labelText: 'Email',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: _emailValidator, // Apply email validator
//                 ),
//                 SizedBox(height: 20),
//                 TextFormField(
//                   controller: _passwordController,
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     labelText: 'Password',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: _passwordValidator, // Apply password validator
//                 ),
//                 SizedBox(height: 30),
//                 ElevatedButton(
//                   onPressed: _login,
//                   child: Text('Login'),
//                   style: ElevatedButton.styleFrom(
//                     minimumSize: Size(double.infinity, 50),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'customer_home_page.dart';
import 'customer_signup_page.dart'; // Import the Sign-Up Page

class CustomerLoginPage extends StatefulWidget {
  @override
  _CustomerLoginPageState createState() => _CustomerLoginPageState();
}

class _CustomerLoginPageState extends State<CustomerLoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Key for the Form widget
  final _formKey = GlobalKey<FormState>();

  // Email regex pattern
  String? _emailValidator(String? email) {
    if (email == null || email.isEmpty) {
      return 'Please enter an email';
    }
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  // Password validator
  String? _passwordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return 'Please enter a password';
    }
    if (password.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      // If the form is valid, proceed with login logic
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CustomerHomePage()),
      );
    } else {
      // If the form is invalid, show an error message (optional)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fix the errors before submitting')),
      );
    }
  }

  void _navigateToSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CustomerSignupPage()),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey, // Attach the form key
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Customer Login',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 40),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: _emailValidator, // Apply email validator
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  validator: _passwordValidator, // Apply password validator
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _login,
                  child: Text('Login'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: _navigateToSignUp, // Navigate to Sign Up
                  child: Text(
                    'Don\'t have an account? Sign Up',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

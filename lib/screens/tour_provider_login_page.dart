// // import 'package:flutter/material.dart';
// // import 'tour_provider_signup_page.dart';
// // import 'tour_provider_home_page.dart'; // Import the home page

// // class TourProviderLoginPage extends StatefulWidget {
// //   @override
// //   _TourProviderLoginPageState createState() => _TourProviderLoginPageState();
// // }

// // class _TourProviderLoginPageState extends State<TourProviderLoginPage> {
// //   final _emailController = TextEditingController();
// //   final _passwordController = TextEditingController();
// //   final _formKey = GlobalKey<FormState>();

// //   void _login() {
// //     if (_formKey.currentState!.validate()) {
// //       final email = _emailController.text;
// //       final password = _passwordController.text;

// //       // Placeholder for actual authentication logic
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text('Logged in as: $email')),
// //       );

// //       // Navigate to the Tour Provider Home Page
// //       Navigator.pushReplacement(
// //         context,
// //         MaterialPageRoute(
// //           builder: (context) => TourProviderHomePage(companyEmail: email),
// //         ),
// //       );
// //     }
// //   }

// //   @override
// //   void dispose() {
// //     _emailController.dispose();
// //     _passwordController.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       body: Center(
// //         child: Padding(
// //           padding: const EdgeInsets.all(16.0),
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               Text(
// //                 'Tour Provider Login',
// //                 style: TextStyle(
// //                   fontSize: 24,
// //                   fontWeight: FontWeight.bold,
// //                   color: Colors.blue,
// //                 ),
// //               ),
// //               SizedBox(height: 40),
// //               Form(
// //                 key: _formKey,
// //                 child: Column(
// //                   children: [
// //                     TextFormField(
// //                       controller: _emailController,
// //                       keyboardType: TextInputType.emailAddress,
// //                       decoration: InputDecoration(
// //                         labelText: 'Email',
// //                         border: OutlineInputBorder(),
// //                       ),
// //                       validator: (value) {
// //                         if (value == null || value.isEmpty) {
// //                           return 'Please enter your email';
// //                         }
// //                         if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
// //                           return 'Enter a valid email';
// //                         }
// //                         return null;
// //                       },
// //                     ),
// //                     SizedBox(height: 20),
// //                     TextFormField(
// //                       controller: _passwordController,
// //                       obscureText: true,
// //                       decoration: InputDecoration(
// //                         labelText: 'Password',
// //                         border: OutlineInputBorder(),
// //                       ),
// //                       validator: (value) {
// //                         if (value == null || value.isEmpty) {
// //                           return 'Please enter your password';
// //                         }
// //                         return null;
// //                       },
// //                     ),
// //                     SizedBox(height: 30),
// //                     ElevatedButton(
// //                       onPressed: _login,
// //                       child: Text('Login'),
// //                       style: ElevatedButton.styleFrom(
// //                         minimumSize: Size(double.infinity, 50),
// //                         shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(8),
// //                         ),
// //                       ),
// //                     ),
// //                     SizedBox(height: 20),
// //                     TextButton(
// //                       onPressed: () {
// //                         Navigator.push(
// //                           context,
// //                           MaterialPageRoute(
// //                               builder: (context) => TourProviderSignupPage()),
// //                         );
// //                       },
// //                       child: Text('Sign Up'),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'tour_provider_signup_page.dart';
// import 'tour_provider_home_page.dart'; // Import the home page

// class TourProviderLoginPage extends StatefulWidget {
//   @override
//   _TourProviderLoginPageState createState() => _TourProviderLoginPageState();
// }

// class _TourProviderLoginPageState extends State<TourProviderLoginPage> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   void _login() {
//     if (_formKey.currentState!.validate()) {
//       final email = _emailController.text;
//       final password = _passwordController.text;

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Logged in as: $email')),
//       );

//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => TourProviderHomePage(companyEmail: email),
//         ),
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
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           Image.asset(
//             'assets/images/bg.jpg', // Your background image
//             fit: BoxFit.cover,
//           ),
//           Center(
//             child: Container(
//               padding: const EdgeInsets.all(16.0),
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.8),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Tour Provider Login',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.blue,
//                     ),
//                   ),
//                   SizedBox(height: 40),
//                   Form(
//                     key: _formKey,
//                     child: Column(
//                       children: [
//                         TextFormField(
//                           controller: _emailController,
//                           keyboardType: TextInputType.emailAddress,
//                           decoration: InputDecoration(
//                             labelText: 'Email',
//                             border: OutlineInputBorder(),
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter your email';
//                             }
//                             if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
//                                 .hasMatch(value)) {
//                               return 'Enter a valid email';
//                             }
//                             return null;
//                           },
//                         ),
//                         SizedBox(height: 20),
//                         TextFormField(
//                           controller: _passwordController,
//                           obscureText: true,
//                           decoration: InputDecoration(
//                             labelText: 'Password',
//                             border: OutlineInputBorder(),
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter your password';
//                             }
//                             return null;
//                           },
//                         ),
//                         SizedBox(height: 30),
//                         ElevatedButton(
//                           onPressed: _login,
//                           child: Text('Login'),
//                           style: ElevatedButton.styleFrom(
//                             minimumSize: Size(double.infinity, 50),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         TextButton(
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) =>
//                                       TourProviderSignupPage()),
//                             );
//                           },
//                           child: Text('Sign Up'),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'tour_provider_signup_page.dart';
import 'tour_provider_home_page.dart'; // Import the home page

class TourProviderLoginPage extends StatefulWidget {
  const TourProviderLoginPage({super.key});

  @override
  _TourProviderLoginPageState createState() => _TourProviderLoginPageState();
}

class _TourProviderLoginPageState extends State<TourProviderLoginPage> {
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
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zAZ0-9.-]+\.[a-zA-Z]{2,}$');
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
    return null;
  }

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      // If the form is valid, proceed with login logic
      final email = _emailController.text;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => TourProviderHomePage(companyEmail: email),
        ),
      );
    } else {
      // If the form is invalid, show an error message (optional)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please fix the errors before submitting')),
      );
    }
  }

  void _navigateToSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TourProviderSignupPage()),
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
      // No background color here, will be handled by the Container
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/bg.jpg'), // Add your image path here
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content with semi-transparent background
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white
                      .withOpacity(0.8), // Semi-transparent white background
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Form(
                  key: _formKey, // Attach the form key
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Tour Provider Login',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      const SizedBox(height: 40),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        validator: _emailValidator, // Apply email validator
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                        validator:
                            _passwordValidator, // Apply password validator
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: Colors.teal, // Corrected property
                        ),
                        child: const Text('Login'),
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: _navigateToSignUp, // Navigate to Sign Up
                        child: const Text(
                          'Don\'t have an account? Sign Up',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

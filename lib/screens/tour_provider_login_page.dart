// // import 'package:flutter/material.dart';

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

// //       // Placeholder for authentication logic
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text('Logged in as: $email')),
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
// //       appBar: AppBar(
// //         title: Text('Tour Provider Login'),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Form(
// //           key: _formKey,
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               Text(
// //                 'Tour Provider Login',
// //                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
// //               ),
// //               SizedBox(height: 30),
// //               TextFormField(
// //                 controller: _emailController,
// //                 keyboardType: TextInputType.emailAddress,
// //                 decoration: InputDecoration(
// //                   labelText: 'Email',
// //                   border: OutlineInputBorder(),
// //                 ),
// //                 validator: (value) {
// //                   if (value == null || value.isEmpty) {
// //                     return 'Please enter your email';
// //                   }
// //                   if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
// //                     return 'Enter a valid email';
// //                   }
// //                   return null;
// //                 },
// //               ),
// //               SizedBox(height: 20),
// //               TextFormField(
// //                 controller: _passwordController,
// //                 obscureText: true,
// //                 decoration: InputDecoration(
// //                   labelText: 'Password',
// //                   border: OutlineInputBorder(),
// //                 ),
// //                 validator: (value) {
// //                   if (value == null || value.isEmpty) {
// //                     return 'Please enter your password';
// //                   }
// //                   return null;
// //                 },
// //               ),
// //               SizedBox(height: 30),
// //               ElevatedButton(
// //                 onPressed: _login,
// //                 child: Text('Login'),
// //                 style: ElevatedButton.styleFrom(
// //                   minimumSize: Size(double.infinity, 50),
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

//       // Placeholder for authentication logic
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Logged in as: $email')),
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
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'Tour Provider Login',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.blue,
//                 ),
//               ),
//               SizedBox(height: 40),
//               Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       controller: _emailController,
//                       keyboardType: TextInputType.emailAddress,
//                       decoration: InputDecoration(
//                         labelText: 'Email',
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your email';
//                         }
//                         if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//                           return 'Enter a valid email';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 20),
//                     TextFormField(
//                       controller: _passwordController,
//                       obscureText: true,
//                       decoration: InputDecoration(
//                         labelText: 'Password',
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your password';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 30),
//                     ElevatedButton(
//                       onPressed: _login,
//                       child: Text('Login'),
//                       style: ElevatedButton.styleFrom(
//                         minimumSize: Size(double.infinity, 50),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => TourProviderSignupPage()),
//                         );
//                       },
//                       child: Text('Sign Up'),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'tour_provider_signup_page.dart';
import 'tour_provider_home_page.dart'; // Import the home page

class TourProviderLoginPage extends StatefulWidget {
  @override
  _TourProviderLoginPageState createState() => _TourProviderLoginPageState();
}

class _TourProviderLoginPageState extends State<TourProviderLoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _login() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;

      // Placeholder for actual authentication logic
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logged in as: $email')),
      );

      // Navigate to the Tour Provider Home Page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => TourProviderHomePage(),
        ),
      );
    }
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Tour Provider Login',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: _login,
                      child: Text('Login'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TourProviderSignupPage()),
                        );
                      },
                      child: Text('Sign Up'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

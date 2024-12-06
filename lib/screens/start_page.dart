// // import 'package:flutter/material.dart';
// // import 'customer_login_page.dart';
// // import 'tour_provider_login_page.dart';

// // class StartPage extends StatelessWidget {
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
// //                 'Welcome to Tour Tango!',
// //                 style: TextStyle(
// //                   fontSize: 24,
// //                   fontWeight: FontWeight.bold,
// //                   color: Colors.blue,
// //                 ),
// //               ),
// //               SizedBox(height: 40),
// //               ElevatedButton(
// //                 onPressed: () {
// //                   Navigator.push(
// //                     context,
// //                     MaterialPageRoute(
// //                         builder: (context) => CustomerLoginPage()),
// //                   );
// //                 },
// //                 style: ElevatedButton.styleFrom(
// //                   minimumSize: Size(double.infinity, 50),
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(8),
// //                   ),
// //                 ),
// //                 child: Text('I am a Customer'),
// //               ),
// //               SizedBox(height: 20),
// //               ElevatedButton(
// //                 onPressed: () {
// //                   Navigator.push(
// //                     context,
// //                     MaterialPageRoute(
// //                         builder: (context) => TourProviderLoginPage()),
// //                   );
// //                 },
// //                 style: ElevatedButton.styleFrom(
// //                   minimumSize: Size(double.infinity, 50),
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(8),
// //                   ),
// //                 ),
// //                 child: Text('I am a Tour Provider'),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'customer_login_page.dart';
// import 'tour_provider_login_page.dart';

// class StartPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white, // Absolute white background
//       body: Column(
//         children: [
//           // Top Section: Background Image
//           Expanded(
//             flex: 3,
//             child: Stack(
//               children: [
//                 // Background Image
//                 Container(
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage('assets/images/logo2'), // Your image
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 // Overlay Title
//                 Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Container(
//                     padding:
//                         const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
//                     color: Colors.black.withOpacity(0.4), // Transparent overlay
//                     child: Text(
//                       'Welcome to Tour Tango!',
//                       style: TextStyle(
//                         fontSize: 28,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         letterSpacing: 1.5,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // Bottom Section: Buttons
//           Expanded(
//             flex: 2,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Button: Customer
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => CustomerLoginPage()),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xFFB2DFDB), // Pastel teal
//                       foregroundColor: Colors.teal.shade900, // Text color
//                       minimumSize: Size(double.infinity, 60),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       elevation: 4, // Soft shadow
//                     ),
//                     child: Text(
//                       'I am a Customer',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   // Button: Tour Provider
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => TourProviderLoginPage()),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xFFBBDEFB), // Pastel blue
//                       foregroundColor: Colors.blue.shade900, // Text color
//                       minimumSize: Size(double.infinity, 60),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       elevation: 4, // Soft shadow
//                     ),
//                     child: Text(
//                       'I am a Tour Provider',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w500,
//                       ),
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
import 'customer_login_page.dart';
import 'tour_provider_login_page.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Top Section: Tour Tango Title
          const Expanded(
            flex: 3, // Takes 1/6th of the screen
            child: Center(
              child: Text(
                'TOUR TANGO',
                style: TextStyle(
                  fontSize: 46,
                  //fontStyle: lora,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 97, 197, 187),
                  letterSpacing: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // Middle Section: Full-Width Image
          Expanded(
            flex: 4, // Takes 3/6th of the screen
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/logo2'), // Your image
                  fit: BoxFit.cover, // Ensures the image covers the width
                ),
              ),
            ),
          ),
          // Bottom Section: Buttons
          Expanded(
            flex: 3, // Takes 2/6th of the screen
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Button: Customer
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CustomerLoginPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(
                          255, 115, 198, 191), // Pastel teal
                      foregroundColor: Colors.white, // White text
                      minimumSize: const Size(double.infinity, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4, // Soft shadow
                    ),
                    child: const Text(
                      'I am a Customer',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Button: Tour Provider
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const TourProviderLoginPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(
                          255, 115, 198, 191), // Same color as Customer button
                      foregroundColor: Colors.white, // White text
                      minimumSize: const Size(double.infinity, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4, // Soft shadow
                    ),
                    child: const Text(
                      'I am a Tour Provider',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

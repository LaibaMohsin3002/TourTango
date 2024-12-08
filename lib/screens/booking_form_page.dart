// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:flutter/services.dart';
// // // // // import 'booking_confirmation_page.dart'; // Import Booking Confirmation Page

// // // // // class BookingFormPage extends StatefulWidget {
// // // // //   final String packageName;

// // // // //   const BookingFormPage({super.key, required this.packageName});

// // // // //   @override
// // // // //   _BookingFormPageState createState() => _BookingFormPageState();
// // // // // }

// // // // // class _BookingFormPageState extends State<BookingFormPage> {
// // // // //   final _formKey = GlobalKey<FormState>();
// // // // //   final _nameController = TextEditingController();
// // // // //   final _emailController = TextEditingController();
// // // // //   final _phoneController = TextEditingController();

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Scaffold(
// // // // //       appBar: AppBar(
// // // // //         title: Text('Book ${widget.packageName}'),
// // // // //       ),
// // // // //       body: Padding(
// // // // //         padding: const EdgeInsets.all(16.0),
// // // // //         child: Form(
// // // // //           key: _formKey,
// // // // //           child: Column(
// // // // //             children: [
// // // // //               TextFormField(
// // // // //                 controller: _nameController,
// // // // //                 decoration: const InputDecoration(labelText: 'Name'),
// // // // //                 validator: (value) =>
// // // // //                     value!.isEmpty ? 'Please enter your name' : null,
// // // // //               ),
// // // // //               const SizedBox(height: 16),
// // // // //               TextFormField(
// // // // //                 controller: _emailController,
// // // // //                 decoration: const InputDecoration(labelText: 'Email'),
// // // // //                 validator: (value) {
// // // // //                   if (value == null || value.isEmpty) {
// // // // //                     return 'Please enter your email';
// // // // //                   }
// // // // //                   final emailRegex = RegExp(
// // // // //                       r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
// // // // //                   if (!emailRegex.hasMatch(value)) {
// // // // //                     return 'Enter a valid email';
// // // // //                   }
// // // // //                   return null;
// // // // //                 },
// // // // //               ),
// // // // //               const SizedBox(height: 16),
// // // // //               TextFormField(
// // // // //                 controller: _phoneController,
// // // // //                 decoration: const InputDecoration(labelText: 'Phone Number'),
// // // // //                 keyboardType: TextInputType.phone,
// // // // //                 inputFormatters: [FilteringTextInputFormatter.digitsOnly],
// // // // //                 validator: (value) =>
// // // // //                     value!.isEmpty ? 'Please enter your phone number' : null,
// // // // //               ),
// // // // //               const Spacer(),
// // // // //               ElevatedButton(
// // // // //                 onPressed: () {
// // // // //                   if (_formKey.currentState?.validate() ?? false) {
// // // // //                     Navigator.push(
// // // // //                       context,
// // // // //                       MaterialPageRoute(
// // // // //                         builder: (context) => BookingConfirmationPage(
// // // // //                           name: _nameController.text,
// // // // //                           email: _emailController.text,
// // // // //                           phone: _phoneController.text,
// // // // //                           packageName: widget.packageName,
// // // // //                         ),
// // // // //                       ),
// // // // //                     );
// // // // //                   }
// // // // //                 },
// // // // //                 style: ElevatedButton.styleFrom(
// // // // //                   minimumSize: const Size(double.infinity, 50),
// // // // //                 ),
// // // // //                 child: const Text('Confirm Booking'),
// // // // //               ),
// // // // //             ],
// // // // //           ),
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }

// // // // import 'package:flutter/material.dart';
// // // // import 'package:flutter/services.dart';
// // // // import 'package:intl/intl.dart';
// // // // import 'package:tourtango/main.dart';
// // // // import 'booking_confirmation_page.dart';

// // // // class BookingFormPage extends StatefulWidget {
// // // //   final String packageName;
// // // //   final String tourCompany;
// // // //   final String duration;
// // // //   final String price;

// // // //   const BookingFormPage({
// // // //     super.key,
// // // //     required this.packageName,
// // // //     required this.tourCompany,
// // // //     required this.duration,
// // // //     required this.price,
// // // //   });

// // // //   @override
// // // //   State<BookingFormPage> createState() => _BookingFormPageState();
// // // // }

// // // // class _BookingFormPageState extends State<BookingFormPage> {
// // // //   final _formKey = GlobalKey<FormState>();
// // // //   final _nameController = TextEditingController();
// // // //   final _emailController = TextEditingController();
// // // //   final _phoneController = TextEditingController();

// // // //   late String currentDate;

// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       backgroundColor: const Color.fromARGB(255, 238, 242, 239), // Pastel green
// // // //       appBar: AppBar(
// // // //         title: Text('Book ${widget.packageName}'),
// // // //         backgroundColor:
// // // //             const Color.fromARGB(255, 100, 131, 156), // Pastel theme
// // // //       ),
// // // //       body: Padding(
// // // //         padding: const EdgeInsets.all(16.0),
// // // //         child: Form(
// // // //           key: _formKey,
// // // //           child: Column(
// // // //             children: [
// // // //               _buildInfoDisplay('Package Name', widget.packageName),
// // // //               _buildInfoDisplay('Tour Company', widget.tourCompany),
// // // //               _buildInfoDisplay('Duration', widget.duration),
// // // //               _buildInfoDisplay('Price', widget.price),
// // // //               _buildInfoDisplay('Booking Date', currentDate),
// // // //               const SizedBox(height: 16),
// // // //               TextFormField(
// // // //                 controller: _nameController,
// // // //                 decoration: const InputDecoration(labelText: 'Name'),
// // // //                 validator: (value) =>
// // // //                     value!.isEmpty ? 'Please enter your name' : null,
// // // //               ),
// // // //               const SizedBox(height: 16),
// // // //               TextFormField(
// // // //                 controller: _emailController,
// // // //                 decoration: const InputDecoration(labelText: 'Email'),
// // // //                 validator: (value) {
// // // //                   if (value == null || value.isEmpty) {
// // // //                     return 'Please enter your email';
// // // //                   }
// // // //                   if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
// // // //                     return 'Enter a valid email';
// // // //                   }
// // // //                   return null;
// // // //                 },
// // // //               ),
// // // //               const SizedBox(height: 16),
// // // //               TextFormField(
// // // //                 controller: _phoneController,
// // // //                 decoration: const InputDecoration(labelText: 'Phone Number'),
// // // //                 keyboardType: TextInputType.phone,
// // // //                 inputFormatters: [FilteringTextInputFormatter.digitsOnly],
// // // //                 validator: (value) =>
// // // //                     value!.isEmpty ? 'Please enter your phone number' : null,
// // // //               ),
// // // //               ElevatedButton(
// // // //                 onPressed: () {
// // // //                   if (_formKey.currentState!.validate()) {
// // // //                     // Show notification when button is pressed
// // // //                     notificationService.showNotification(
// // // //                       id: 1,
// // // //                       title: 'Booking Confirmed',
// // // //                       body:
// // // //                           'Your booking for the package "${widget.packageName}" has been confirmed.',
// // // //                     );

// // // //                     // Navigate to the BookingConfirmationPage
// // // //                     Navigator.push(
// // // //                       context,
// // // //                       MaterialPageRoute(
// // // //                         builder: (context) => BookingConfirmationPage(
// // // //                           name: _nameController.text,
// // // //                           email: _emailController.text,
// // // //                           phone: _phoneController.text,
// // // //                           packageName: widget.packageName,
// // // //                           tourCompany: widget.tourCompany,
// // // //                           duration: widget.duration,
// // // //                           price: widget.price,
// // // //                           bookingDate: currentDate,
// // // //                         ),
// // // //                       ),
// // // //                     );
// // // //                   }
// // // //                 },
// // // //                 style: ElevatedButton.styleFrom(
// // // //                   backgroundColor: const Color.fromARGB(255, 160, 188, 177),
// // // //                   minimumSize: const Size(double.infinity, 50),
// // // //                   shape: RoundedRectangleBorder(
// // // //                     borderRadius: BorderRadius.circular(25),
// // // //                   ),
// // // //                 ),
// // // //                 child: const Text('Confirm Booking'),
// // // //               )

// // // //               // const Spacer(),
// // // //               // ElevatedButton(
// // // //               //   onPressed: () {
// // // //               //     if (_formKey.currentState!.validate()) {
// // // //               //       Navigator.push(
// // // //               //         context,
// // // //               //         MaterialPageRoute(
// // // //               //           builder: (context) => BookingConfirmationPage(
// // // //               //             name: _nameController.text,
// // // //               //             email: _emailController.text,
// // // //               //             phone: _phoneController.text,
// // // //               //             packageName: widget.packageName,
// // // //               //             tourCompany: widget.tourCompany,
// // // //               //             duration: widget.duration,
// // // //               //             price: widget.price,
// // // //               //             bookingDate: currentDate,
// // // //               //           ),
// // // //               //         ),
// // // //               //       );
// // // //               //     }
// // // //               //   },
// // // //               //   style: ElevatedButton.styleFrom(
// // // //               //     backgroundColor: const Color.fromARGB(255, 160, 188, 177),
// // // //               //     minimumSize: const Size(double.infinity, 50),
// // // //               //     shape: RoundedRectangleBorder(
// // // //               //       borderRadius: BorderRadius.circular(25),
// // // //               //     ),
// // // //               //   ),
// // // //               //   child: const Text('Confirm Booking'),
// // // //               // ),
// // // //             ],
// // // //           ),
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _buildInfoDisplay(String label, String value) {
// // // //     return Container(
// // // //       padding: const EdgeInsets.all(16.0),
// // // //       decoration: BoxDecoration(
// // // //         color: Colors.white,
// // // //         borderRadius: BorderRadius.circular(20),
// // // //         boxShadow: [
// // // //           BoxShadow(
// // // //             color: Colors.black.withOpacity(0.1),
// // // //             blurRadius: 5,
// // // //             spreadRadius: 2,
// // // //           ),
// // // //         ],
// // // //       ),
// // // //       child: Row(
// // // //         children: [
// // // //           const Icon(Icons.info_outline,
// // // //               color: Color.fromARGB(255, 100, 131, 156)),
// // // //           const SizedBox(width: 16),
// // // //           Expanded(
// // // //             child: Text(
// // // //               "$label: $value",
// // // //               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
// // // //             ),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // import 'package:flutter/material.dart';
// // // import 'package:flutter/services.dart';
// // // import 'package:intl/intl.dart';
// // // import 'package:tourtango/notification.dart';
// // // //import 'notification_service.dart';  // Import your notification service
// // // import 'booking_confirmation_page.dart';

// // // class BookingFormPage extends StatefulWidget {
// // //   final String packageName;
// // //   final String tourCompany;
// // //   final String duration;
// // //   final String price;

// // //   const BookingFormPage({
// // //     super.key,
// // //     required this.packageName,
// // //     required this.tourCompany,
// // //     required this.duration,
// // //     required this.price,
// // //   });

// // //   @override
// // //   State<BookingFormPage> createState() => _BookingFormPageState();
// // // }

// // // class _BookingFormPageState extends State<BookingFormPage> {
// // //   final _formKey = GlobalKey<FormState>();
// // //   final _nameController = TextEditingController();
// // //   final _emailController = TextEditingController();
// // //   final _phoneController = TextEditingController();

// // //   late String currentDate;
// // //   late NotificationService notificationService;

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

// // //     // Initialize the notification service
// // //     notificationService = NotificationService();
// // //     notificationService.initialize();
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       backgroundColor: const Color.fromARGB(255, 238, 242, 239), // Pastel green
// // //       appBar: AppBar(
// // //         title: Text('Book ${widget.packageName}'),
// // //         backgroundColor:
// // //             const Color.fromARGB(255, 100, 131, 156), // Pastel theme
// // //       ),
// // //       body: Padding(
// // //         padding: const EdgeInsets.all(16.0),
// // //         child: Form(
// // //           key: _formKey,
// // //           child: Column(
// // //             children: [
// // //               _buildInfoDisplay('Package Name', widget.packageName),
// // //               _buildInfoDisplay('Tour Company', widget.tourCompany),
// // //               _buildInfoDisplay('Duration', widget.duration),
// // //               _buildInfoDisplay('Price', widget.price),
// // //               _buildInfoDisplay('Booking Date', currentDate),
// // //               const SizedBox(height: 16),
// // //               TextFormField(
// // //                 controller: _nameController,
// // //                 decoration: const InputDecoration(labelText: 'Name'),
// // //                 validator: (value) =>
// // //                     value!.isEmpty ? 'Please enter your name' : null,
// // //               ),
// // //               const SizedBox(height: 16),
// // //               TextFormField(
// // //                 controller: _emailController,
// // //                 decoration: const InputDecoration(labelText: 'Email'),
// // //                 validator: (value) {
// // //                   if (value == null || value.isEmpty) {
// // //                     return 'Please enter your email';
// // //                   }
// // //                   if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
// // //                     return 'Enter a valid email';
// // //                   }
// // //                   return null;
// // //                 },
// // //               ),
// // //               const SizedBox(height: 16),
// // //               TextFormField(
// // //                 controller: _phoneController,
// // //                 decoration: const InputDecoration(labelText: 'Phone Number'),
// // //                 keyboardType: TextInputType.phone,
// // //                 inputFormatters: [FilteringTextInputFormatter.digitsOnly],
// // //                 validator: (value) =>
// // //                     value!.isEmpty ? 'Please enter your phone number' : null,
// // //               ),
// // //               ElevatedButton(
// // //                 onPressed: () {
// // //                   if (_formKey.currentState!.validate()) {
// // //                     // Show notification when button is pressed
// // //                     notificationService.showNotification(
// // //                       id: 1,
// // //                       title: 'Booking Confirmed',
// // //                       body:
// // //                           'Your booking for the package "${widget.packageName}" has been confirmed.',
// // //                     );

// // //                     // Navigate to the BookingConfirmationPage
// // //                     Navigator.push(
// // //                       context,
// // //                       MaterialPageRoute(
// // //                         builder: (context) => BookingConfirmationPage(
// // //                           name: _nameController.text,
// // //                           email: _emailController.text,
// // //                           phone: _phoneController.text,
// // //                           packageName: widget.packageName,
// // //                           tourCompany: widget.tourCompany,
// // //                           duration: widget.duration,
// // //                           price: widget.price,
// // //                           bookingDate: currentDate,
// // //                         ),
// // //                       ),
// // //                     );
// // //                   }
// // //                 },
// // //                 style: ElevatedButton.styleFrom(
// // //                   backgroundColor: const Color.fromARGB(255, 160, 188, 177),
// // //                   minimumSize: const Size(double.infinity, 50),
// // //                   shape: RoundedRectangleBorder(
// // //                     borderRadius: BorderRadius.circular(25),
// // //                   ),
// // //                 ),
// // //                 child: const Text('Confirm Booking'),
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildInfoDisplay(String label, String value) {
// // //     return Container(
// // //       padding: const EdgeInsets.all(16.0),
// // //       decoration: BoxDecoration(
// // //         color: Colors.white,
// // //         borderRadius: BorderRadius.circular(20),
// // //         boxShadow: [
// // //           BoxShadow(
// // //             color: Colors.black.withOpacity(0.1),
// // //             blurRadius: 5,
// // //             spreadRadius: 2,
// // //           ),
// // //         ],
// // //       ),
// // //       child: Row(
// // //         children: [
// // //           const Icon(Icons.info_outline,
// // //               color: Color.fromARGB(255, 100, 131, 156)),
// // //           const SizedBox(width: 16),
// // //           Expanded(
// // //             child: Text(
// // //               "$label: $value",
// // //               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }

// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:intl/intl.dart';
// // import 'package:tourtango/notification.dart';
// // //import 'notification_service.dart'; // Import your notification service
// // import 'booking_confirmation_page.dart';

// // class BookingFormPage extends StatefulWidget {
// //   final String packageName;
// //   final String tourCompany;
// //   final String duration;
// //   final String price;

// //   const BookingFormPage({
// //     super.key,
// //     required this.packageName,
// //     required this.tourCompany,
// //     required this.duration,
// //     required this.price,
// //   });

// //   @override
// //   State<BookingFormPage> createState() => _BookingFormPageState();
// // }

// // class _BookingFormPageState extends State<BookingFormPage> {
// //   final _formKey = GlobalKey<FormState>();
// //   final _nameController = TextEditingController();
// //   final _emailController = TextEditingController();
// //   final _phoneController = TextEditingController();

// //   late String currentDate;

// //   // Create instance of NotificationService
// //   final NotificationService notificationService = NotificationService();

// //   @override
// //   void initState() {
// //     super.initState();
// //     currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
// //     // Initialize the notification service
// //     notificationService.initialize();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: const Color.fromARGB(255, 238, 242, 239), // Pastel green
// //       appBar: AppBar(
// //         title: Text('Book ${widget.packageName}'),
// //         backgroundColor:
// //             const Color.fromARGB(255, 100, 131, 156), // Pastel theme
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Form(
// //           key: _formKey,
// //           child: Column(
// //             children: [
// //               _buildInfoDisplay('Package Name', widget.packageName),
// //               _buildInfoDisplay('Tour Company', widget.tourCompany),
// //               _buildInfoDisplay('Duration', widget.duration),
// //               _buildInfoDisplay('Price', widget.price),
// //               _buildInfoDisplay('Booking Date', currentDate),
// //               const SizedBox(height: 16),
// //               TextFormField(
// //                 controller: _nameController,
// //                 decoration: const InputDecoration(labelText: 'Name'),
// //                 validator: (value) =>
// //                     value!.isEmpty ? 'Please enter your name' : null,
// //               ),
// //               const SizedBox(height: 16),
// //               TextFormField(
// //                 controller: _emailController,
// //                 decoration: const InputDecoration(labelText: 'Email'),
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
// //               const SizedBox(height: 16),
// //               TextFormField(
// //                 controller: _phoneController,
// //                 decoration: const InputDecoration(labelText: 'Phone Number'),
// //                 keyboardType: TextInputType.phone,
// //                 inputFormatters: [FilteringTextInputFormatter.digitsOnly],
// //                 validator: (value) =>
// //                     value!.isEmpty ? 'Please enter your phone number' : null,
// //               ),
// //               ElevatedButton(
// //                 onPressed: () {
// //                   if (_formKey.currentState!.validate()) {
// //                     // Show notification when button is pressed
// //                     notificationService.showNotification(
// //                       id: 1,
// //                       title: 'Booking Confirmed',
// //                       body:
// //                           'Your booking for the package "${widget.packageName}" has been confirmed.',
// //                     );

// //                     // Navigate to the BookingConfirmationPage
// //                     Navigator.push(
// //                       context,
// //                       MaterialPageRoute(
// //                         builder: (context) => BookingConfirmationPage(
// //                           name: _nameController.text,
// //                           email: _emailController.text,
// //                           phone: _phoneController.text,
// //                           packageName: widget.packageName,
// //                           tourCompany: widget.tourCompany,
// //                           duration: widget.duration,
// //                           price: widget.price,
// //                           bookingDate: currentDate,
// //                         ),
// //                       ),
// //                     );
// //                   }
// //                 },
// //                 style: ElevatedButton.styleFrom(
// //                   backgroundColor: const Color.fromARGB(255, 160, 188, 177),
// //                   minimumSize: const Size(double.infinity, 50),
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(25),
// //                   ),
// //                 ),
// //                 child: const Text('Confirm Booking'),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildInfoDisplay(String label, String value) {
// //     return Container(
// //       padding: const EdgeInsets.all(16.0),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(20),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.1),
// //             blurRadius: 5,
// //             spreadRadius: 2,
// //           ),
// //         ],
// //       ),
// //       child: Row(
// //         children: [
// //           const Icon(Icons.info_outline,
// //               color: Color.fromARGB(255, 100, 131, 156)),
// //           const SizedBox(width: 16),
// //           Expanded(
// //             child: Text(
// //               "$label: $value",
// //               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';
// import 'package:tourtango/notification.dart';
// import 'booking_confirmation_page.dart';

// class BookingFormPage extends StatefulWidget {
//   final String packageName;
//   final String tourCompany;
//   final String duration;
//   final String price;

//   const BookingFormPage({
//     super.key,
//     required this.packageName,
//     required this.tourCompany,
//     required this.duration,
//     required this.price,
//   });

//   @override
//   State<BookingFormPage> createState() => _BookingFormPageState();
// }

// class _BookingFormPageState extends State<BookingFormPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _numberOfPeopleController =
//       TextEditingController(); // Controller for number of people

//   late String currentDate;

//   // Create instance of NotificationService
//   final NotificationService notificationService = NotificationService();

//   @override
//   void initState() {
//     super.initState();
//     currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
//     notificationService.initialize(); // Initialize the notification service
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 238, 242, 239), // Pastel green
//       appBar: AppBar(
//         title: Text('Book ${widget.packageName}'),
//         backgroundColor:
//             const Color.fromARGB(255, 100, 131, 156), // Pastel theme
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               _buildInfoDisplay('Package Name', widget.packageName),
//               _buildInfoDisplay('Tour Company', widget.tourCompany),
//               _buildInfoDisplay('Duration', widget.duration),
//               _buildInfoDisplay('Price', widget.price),
//               _buildInfoDisplay('Booking Date', currentDate),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: _nameController,
//                 decoration: const InputDecoration(labelText: 'Name'),
//                 validator: (value) =>
//                     value!.isEmpty ? 'Please enter your name' : null,
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: _emailController,
//                 decoration: const InputDecoration(labelText: 'Email'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your email';
//                   }
//                   if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//                     return 'Enter a valid email';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: _phoneController,
//                 decoration: const InputDecoration(labelText: 'Phone Number'),
//                 keyboardType: TextInputType.phone,
//                 inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//                 validator: (value) =>
//                     value!.isEmpty ? 'Please enter your phone number' : null,
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: _numberOfPeopleController,
//                 decoration:
//                     const InputDecoration(labelText: 'Number of People'),
//                 keyboardType: TextInputType.number,
//                 inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the number of people';
//                   }
//                   if (int.tryParse(value) == null || int.parse(value) <= 0) {
//                     return 'Enter a valid number greater than 0';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     notificationService.showNotification(
//                       id: 1,
//                       title: 'Booking Confirmed',
//                       body:
//                           'Your booking for the package "${widget.packageName}" has been confirmed.',
//                     );

//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => BookingConfirmationPage(
//                           name: _nameController.text,
//                           email: _emailController.text,
//                           phone: _phoneController.text,
//                           packageName: widget.packageName,
//                           tourCompany: widget.tourCompany,
//                           duration: widget.duration,
//                           price: widget.price,
//                           bookingDate: currentDate,
//                           numberOfPeople: _numberOfPeopleController.text,
//                         ),
//                       ),
//                     );
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color.fromARGB(255, 160, 188, 177),
//                   minimumSize: const Size(double.infinity, 50),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(25),
//                   ),
//                 ),
//                 child: const Text('Confirm Booking'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoDisplay(String label, String value) {
//     return Container(
//       padding: const EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 5,
//             spreadRadius: 2,
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.info_outline,
//               color: Color.fromARGB(255, 100, 131, 156)),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Text(
//               "$label: $value",
//               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tourtango/notification.dart';
import 'booking_confirmation_page.dart';
import 'package:tourtango/api.dart';

class BookingFormPage extends StatefulWidget {
  final int packageId;
  final String customerEmail;
  final double price;

  const BookingFormPage({
    Key? key,
    required this.packageId,
    required this.customerEmail,
    required this.price,
  }) : super(key: key);

  @override
  State<BookingFormPage> createState() => _BookingFormPageState();
}


class _BookingFormPageState extends State<BookingFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _numberOfPeopleController = TextEditingController();
  final NotificationService notificationService = NotificationService();
  final String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String tourCompany='';
  String duration ='';

  @override
void initState() {
  super.initState();
  fetchPackageDetails();
}

Future<void> fetchPackageDetails() async {
  try {
    final packageDetails = await getPackageDetails(widget.packageId);
    final String? startDateString = packageDetails['start_date'];
    final String? endDateString = packageDetails['end_date'];

    if (startDateString != null && endDateString != null) {
      try {
        final startDate = DateTime.parse(startDateString);
        final endDate = DateTime.parse(endDateString);

        setState(() {
          tourCompany = packageDetails['companyName'];
          duration = '${endDate.difference(startDate).inDays} days';
        });
      } catch (dateError) {
        setState(() {
          tourCompany = packageDetails['companyName'] ?? 'Unknown';
          duration = 'Invalid date format';
        });
      }
    } else {
      setState(() {
        tourCompany = packageDetails['companyName'] ?? 'Unknown';
        duration = 'Dates not available';
      });
    }
  } catch (error) {
    setState(() {
      tourCompany = 'Unknown';
      duration = 'Error fetching details';
    });
  }
}

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _numberOfPeopleController.dispose();
    super.dispose();
  }
  

  Widget _buildInfoDisplay(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255), // Pastel green
      appBar: AppBar(
        title: Text('Book Package ${widget.packageId}'),
        backgroundColor:
            const Color.fromARGB(255, 100, 131, 156), // Pastel blue
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // _buildInfoDisplay(
                //     'Tour Company', widget.tourCompany.toString()),
                _buildInfoDisplay('Tour Company', tourCompany.isNotEmpty? tourCompany: 'Unknown Company'),

                _buildInfoDisplay('Package ID', widget.packageId.toString()),
                _buildInfoDisplay('Duration', duration),
                _buildInfoDisplay('Customer Email', widget.customerEmail),
                _buildInfoDisplay(
                    'Price', '\$${widget.price.toStringAsFixed(2)}'),
                const SizedBox(height: 16),
                // TextFormField(
                //   controller: _nameController,
                //   decoration: const InputDecoration(labelText: 'Name'),
                //   validator: (value) =>
                //       value!.isEmpty ? 'Please enter your name' : null,
                // ),
                // const SizedBox(height: 16),
                // TextFormField(
                //   controller: _phoneController,
                //   decoration: const InputDecoration(labelText: 'Phone Number'),
                //   keyboardType: TextInputType.phone,
                //   validator: (value) =>
                //       value!.isEmpty ? 'Please enter your phone number' : null,
                // ),
                // const SizedBox(height: 16),
                // TextFormField(
                //   controller: _numberOfPeopleController,
                //   decoration:
                //       const InputDecoration(labelText: 'Number of People'),
                //   keyboardType: TextInputType.number,
                //   validator: (value) => value!.isEmpty
                //       ? 'Please enter the number of people'
                //       : null,
                // ),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          30.0), // Makes the border rounded
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 16.0), // Adds padding inside the field
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your name' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 16.0),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your phone number' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _numberOfPeopleController,
                  decoration: InputDecoration(
                    labelText: 'Number of People',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 16.0),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty
                      ? 'Please enter the number of people'
                      : null,
                ),

                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      notificationService.showNotification(
                        id: 1,
                        title: 'Booking Confirmed',
                        body:
                            'Your booking for package ID ${widget.packageId} has been confirmed.',
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingConfirmationPage(
                            name: _nameController.text,
                            email: widget.customerEmail,
                            phone: _phoneController.text,
                            packageId: widget.packageId,
                            tourCompany: tourCompany,
                            duration: duration,
                            price: widget.price,
                            bookingDate: currentDate,
                            numberOfPeople: _numberOfPeopleController.text,
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(
                        255, 176, 174, 196), // Pastel theme
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text('Confirm Booking'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

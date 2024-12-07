// import 'package:flutter/material.dart';
// import 'screens/start_page.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Login Demo',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: LoginPage(),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'screens/start_page.dart';

// void main () {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Tour Tango',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: StartPage(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core
import 'package:tourtango/notification.dart';
// import 'package:tourtango/notification.dart';
import 'screens/start_page.dart';

// NotificationService notificationService = NotificationService();

void main() async {
  // Ensure that widget binding is initialized before Firebase is initialized
  // WidgetsFlutterBinding.ensureInitialized();
  // await NotificationService().initNotification();

  WidgetsFlutterBinding.ensureInitialized();

  // Initialize NotificationService
  NotificationService().initialize();

  // Initialize Firebase
  await Firebase.initializeApp();

  //await notificationService.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tour Tango',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const StartPage(),
    );
  }
}

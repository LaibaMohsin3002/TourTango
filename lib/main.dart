import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tourtango/notification.dart';
import 'screens/start_page.dart';



void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // Initialize NotificationService
  NotificationService().initialize();

  // Initialize Firebase
  await Firebase.initializeApp();


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

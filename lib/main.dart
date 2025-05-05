import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tourtango/notification.dart';
import 'screens/start_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';



void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // Initialize NotificationService
  NotificationService().initialize();

  await dotenv.load(fileName: ".env");

  Stripe.publishableKey =  dotenv.env['STRIPE_PUBLISHABLE_KEY']!;
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

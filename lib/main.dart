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

import 'package:flutter/material.dart';
import 'screens/start_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tour Tango',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: StartPage(),
    );
  }
}

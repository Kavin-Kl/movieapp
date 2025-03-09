import 'package:flutter/material.dart';
import 'package:movieeee/screens/login.dart';
import 'package:movieeee/screens/home.dart';
import 'package:movieeee/screens/registration.dart';
import 'package:movieeee/screens/logoscreen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Logoscreen(),
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color.fromRGBO(7, 63, 85, 1.0),
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontFamily: 'Angelo', color: Colors.white),
        ),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/logoscreen': (context) => Logoscreen(),
        '/login': (context) => Login(),
        '/home': (context) => Home(),
        '/registration': (context) => Registration(),
      },
    );
  }
}

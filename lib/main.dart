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
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromRGBO(7, 63, 85, 1.0),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontFamily: 'Poppins', color: Colors.white),
        ),
      ),
      initialRoute: '/logoscreen', // Fix: Ensures correct first screen
      routes: {
        '/logoscreen': (context) => const Logoscreen(),
        '/login': (context) => const Login(),
        '/home': (context) => const Home(),
        '/registration': (context) => const Registration(),
      },
    );
  }
}

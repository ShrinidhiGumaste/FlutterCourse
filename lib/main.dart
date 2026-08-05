import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttercourse/app1/screens/home_screen.dart';
import 'package:fluttercourse/grocery_store_app/screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import 'cookbook/demo_tab_screen.dart';
//import 'Screens/navigation/home_screen0.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Course",

      debugShowCheckedModeBanner: kDebugMode,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          brightness: Brightness.light,
        ),

        textTheme: TextTheme(
          titleMedium: const TextStyle(fontSize: 32, color: Colors.white),

          bodyMedium: GoogleFonts.acme(),

          labelMedium: GoogleFonts.vampiroOne(),
        ),
      ),

      home: const GHomeScreen(),

      // OR
      // home: const HomeScreen0(),
    );
  }
}

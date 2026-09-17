import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart%20';
import 'package:fluttercourse/animations/animation_controller/AnimationHomePage.dart';

void main() {// main() => is where the Flutter application starts.
  // runApp() => Tells Flutter "Start my application with this widget."
  runApp(const AnimationControllerApp());
}

class AnimationControllerApp extends StatelessWidget {
  const AnimationControllerApp({super.key}); // This is the constructor for AnimationBuilderApp.

  @override
  Widget build(BuildContext context) {
    return MaterialApp( // MaterialApp is the main container/configuration for the Flutter app.
      // MaterialApp Provides Theme, APP Title, Navigation, Home Screen.
      debugShowCheckedModeBanner: false, // Removing the Debug Banner.
      title: 'AnimationController Demo', // This gives a title for Application.

      theme: ThemeData( // This controls the overall appearance/theme of the app.
        useMaterial3: true, // Uses Flutter's Material 3 design system.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey), // It creates a color scheme based on grey.
      ),
      home: AnimationHomePage(),  // This Tells Flutter that "When the app starts, show AnimationBuilderHomePage."
    );
  }
}

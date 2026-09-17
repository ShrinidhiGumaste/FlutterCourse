import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart%20';
import 'package:fluttercourse/api/screens/api_home_screen.dart';
import 'package:fluttercourse/api/screens/comment_home_screen.dart';
import 'package:fluttercourse/api/screens/photo_home_screen.dart';
import 'package:fluttercourse/api/screens/todo_home_screen.dart';
import 'package:fluttercourse/main.dart';

void main() {
  runApp(const MyApiApp());
}

class MyApiApp extends StatelessWidget {
  const MyApiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: kDebugMode,
      title: 'Posts App',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigoAccent),
      ),
      home: CommentHomeScreen(),
    );
  }
}

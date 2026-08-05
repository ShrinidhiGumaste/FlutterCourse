import 'package:flutter/material.dart';
import 'package:fluttercourse/models/user.dart';

class Screen4 extends StatelessWidget {
  final User user;

  const Screen4({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Screen4")),
      body: Center(
            child: Column(
          children: [
            Text("${user.name}", style: TextStyle(fontWeight: FontWeight.w700)),
            Text("${user.age}"),
            Text("${user.city}"),
            Text("${user.email}"),
            Text("${user.phone}"),
          ],
        ),
      )
    );
  }
}
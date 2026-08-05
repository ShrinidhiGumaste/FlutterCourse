import 'package:flutter/material.dart';
import 'package:fluttercourse/screens/navigation/screen3.dart';
import 'package:fluttercourse/screens/navigation/screen4.dart';

import '../../models/user.dart';

class HomeScreen0 extends StatelessWidget {
  const HomeScreen0({super.key});

  @override
  Widget build(BuildContext context) {
    String name = "Shinu A Gumaste";
    int age = 23;
    String city = "Vijayapura";
    final user = User(
      id: 1,
      name: name,
      age: age,
      email: "sg@gmail.com",
      phone: '+919542*****',
      profileImage: '',
      city: city,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        titleSpacing: 0,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => Screen3(name: name, age: age, city: city),
                  ),
                );
              },
              child: Text("Navigate to another Screen with data"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => Screen4(user: user)));
              },
              child: Text("Navigate with object"),
            ),
          ],
        ),
      ),
    );
  }
}
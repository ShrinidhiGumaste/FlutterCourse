import 'package:flutter/material.dart';

class Screen3 extends StatelessWidget {
  final String name;
  final int age;
  final String city;

  const Screen3({
    super.key,
    required this.name,
    required this.age,
    required this.city,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Screen 3")),
      body: Center(
        child: Column(
          children: [
            Text(
              age > 1
                  ? "Hello $name $age years old"
                  : "Hello $name $age year old",
            ),

            Text("City $city"),
          ],
        ),
      ),
    );
  }
}
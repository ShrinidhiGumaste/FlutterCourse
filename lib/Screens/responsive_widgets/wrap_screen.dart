import 'package:flutter/material.dart';

class WrapScreen extends StatelessWidget {
  const WrapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> frameworks = ['Flutter', 'Swift', 'nextjs'];

    return Scaffold(
      appBar: AppBar(title: Text("Warp Example")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Wrap(
          spacing: 10,
          runSpacing: 8,
          children: frameworks.map((framework) {
            return GestureDetector(
              onTap: () {

              },
              onLongPress: () {

              },
              child: Chip(label: Text(framework)),
            );
          }).toList(),
        ),
      ),
    );
  }
}

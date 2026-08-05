import 'package:flutter/material.dart';

class ExpandedScrren extends StatelessWidget {
  const ExpandedScrren({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("data"), backgroundColor: Colors.green),
      body: Column(
        children: [
          Expanded(flex: 2, child: Container(color: Colors.teal)),
          Expanded(flex: 3, child: Container(color: Colors.red)),
          Expanded(flex: 10, child: Container(color: Colors.blue)),
          Expanded(flex: 1, child: Container(color: Colors.yellow)),
        ],
      ),
    );
  }
}

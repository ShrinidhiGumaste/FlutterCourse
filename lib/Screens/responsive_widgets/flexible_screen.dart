import 'package:flutter/material.dart';

class FlexibleScreen extends StatelessWidget {
  const FlexibleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flexible")),
      body: Row(
        children: [
          Flexible(
            child: Container(
              color: Colors.orange,
              child: Center(child: Text("Flex")),
            ),
          ),
          Container(
            width: 250,
            color: Colors.white,
            child: Center(child: Text("Flex")),
          ),
          Flexible(
            child: Container(
              width: 250,
              color: Colors.green,
              child: Center(child: Text("Flex")),
            ),
          ),
        ],
      ),
    );
  }
}

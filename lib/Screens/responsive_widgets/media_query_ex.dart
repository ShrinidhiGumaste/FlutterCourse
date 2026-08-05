import 'package:flutter/material.dart';

class MediaQueryEx extends StatelessWidget {
  const MediaQueryEx({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: Text("Responsive Widgets")),
      body: Center(
        child: Container(
          width: screenWidth,
          height: screenHeight,
          color: Colors.blue,
          child: Center(
            child: Text(
              "Width: ${screenWidth.toStringAsFixed(0)}, Height: ${screenHeight.toStringAsFixed(0)}",
            ), // 27.567
          ),
        ),
      ),
    );
  }
}

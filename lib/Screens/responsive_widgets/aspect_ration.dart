import 'package:flutter/material.dart';

class AspectRation extends StatelessWidget {
  const AspectRation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Aspect Ratio")),
      body: Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            color: Colors.teal,
            child: const Center(child: Text("16 / 9")),
          ),
        ),
      ),
    );
  }
}

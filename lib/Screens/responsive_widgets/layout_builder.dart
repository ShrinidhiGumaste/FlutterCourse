import 'package:flutter/material.dart';

class LayoutBuilderScreen extends StatelessWidget {
  const LayoutBuilderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Layout Builder")),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return const Center(child: Text("Its a Mobile Layout"));
          } else {
            return const Center(child: Text("Desktop/Tablet Layout"));
          }
        },
      ),
    );
  }
}

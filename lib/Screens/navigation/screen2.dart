import 'package:flutter/material.dart';

class Screen2 extends StatelessWidget {
  const Screen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: true,
        // leading: GestureDetector(
        //   onTap: () {
        //     Navigator.of(context).pop();
        //   },
        //   child: Icon(Icons.wifi),
        // ),
        title: Text("Screen 2,", style: TextStyle(fontWeight: FontWeight.w700)),
      ),
      body: Center(
        child: OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop(); // to go back in stack
          },
          child: Text("Go Back"),
        ),
      ),
    );
  }
}
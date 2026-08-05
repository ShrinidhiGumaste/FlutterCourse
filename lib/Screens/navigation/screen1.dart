import 'package:flutter/material.dart';
import 'package:fluttercourse/screens/navigation/screen2.dart';

class Screen1 extends StatelessWidget {
  const Screen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Screen 1,", style: TextStyle(fontWeight: FontWeight.w700)),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => Screen2()),
            );

            // Navigator.of(
            //   context,
            // ).push(MaterialPageRoute(builder: (context) => Screen2()));
          },
          child: Text("Go to Screen 2"),
        ),
      ),
    );
  }
}
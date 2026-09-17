import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart%20';

void countNumbers(SendPort sendPort) {
  int count = 0;

  for (int i = 0; i <= 100; i++) {
    count++;
  }
  sendPort.send(count);
}

void main() {
  runApp(const MyCounterIsolate());
}

class MyCounterIsolate extends StatelessWidget {
  const MyCounterIsolate({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const CountScreen(),
    );
  }
}

class CountScreen extends StatefulWidget {
  const CountScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CountScreenState();
}

class _CountScreenState extends State<CountScreen> {
  String result = 'Ready';

  Future<void> startCounting() async {
    ReceivePort receivePort = ReceivePort();

    await Isolate.spawn(countNumbers, receivePort.sendPort);

    final answer = await receivePort.first;

    setState(() {
      result = 'Count = $answer';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Counter Isolate',
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.redAccent,
            fontStyle: FontStyle.italic,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),

      body: Center(
        child: Card(
          margin: const EdgeInsets.all(20),

          child: Padding(
            padding: EdgeInsetsGeometry.all(25),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.numbers, size: 60),

                const SizedBox(height: 20),

                Text(
                  result,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: startCounting,
                  child: const Text('Start Counting'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

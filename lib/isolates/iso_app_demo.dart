import 'dart:isolate';

import 'package:flutter/material.dart%20';

void main() {
  runApp(const MyISOApp());
}

void calculateSum(SendPort sendPort) {
  int sum = 0;
  for (int i = 0; i <= 10000000; i++) {
    sum += i;
    debugPrint('$sum');
  }
  sendPort.send(sum);
}

class MyISOApp extends StatelessWidget {
  const MyISOApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Isolate Example')),
        body: Center(
          child: Column(
            children: [
              CircularProgressIndicator(),
              ElevatedButton(
                onPressed: () async {
                  final receivePort = ReceivePort();
                  await Isolate.spawn(calculateSum, receivePort.sendPort);
                  final result = await receivePort.first;
                  debugPrint('Sum = $result');
                },
                child: Text('Calculate'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

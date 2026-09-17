import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart%20';

void addNumbers(List<dynamic> data) {
  SendPort sendPort = data[0];

  int a = data[1];
  int b = data[2];

  int result = a + b;

  sendPort.send(result);
}

void main() {
  runApp(const MySumApp());
}

class MySumApp extends StatelessWidget {
  const MySumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AddScreen(),
    );
  }
}

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AddAcreenState();
}

class _AddAcreenState extends State<AddScreen> {
  // Controllers to take Input from User
  final TextEditingController firstController = TextEditingController();

  final TextEditingController secondContoller = TextEditingController();

  String result = 'Enter Two Numbers';

  Future<void> calculate() async {
    // To Check whether the Fields are Empty....
    if (firstController.text.isEmpty || secondContoller.text.isEmpty) {
      setState(() {
        result = 'Fields Cannot be Empty ⚠️';
      });
      return;
    }

    // Converting STRING to INT....
    int firstNumber = int.parse(firstController.text);
    int secondNumber = int.parse(secondContoller.text);

    // Creating a RECEIVEPORT to Receive RESULT....
    ReceivePort receivePort = ReceivePort();

    // ISOLATE....
    await Isolate.spawn(addNumbers, [
      receivePort.sendPort,
      firstNumber,
      secondNumber,
    ]);

    // Receiving the RESULT....
    final answer = await receivePort.first;

    setState(() {
      result = 'Sum = $answer';
    });

    receivePort.close();

    // Displaying the RESULT....
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Adding Two Numbers',
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.deepOrangeAccent,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.lime,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(25),

            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [
                const Icon(
                  Icons.calculate_outlined,
                  size: 60,
                  color: Colors.blueAccent,
                ),

                const SizedBox(height: 20),

                // For FIRST NUMBER....
                TextField(
                  controller: firstController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: '👉 Enter the First Number',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 20),

                // For SECOND NUMBER....
                TextField(
                  controller: secondContoller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: '👉 Enter the Second Number',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  result,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: calculate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent,
                    foregroundColor: Colors.white,
                  ),
                  child: const Icon(Icons.add_circle, color: Colors.redAccent),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

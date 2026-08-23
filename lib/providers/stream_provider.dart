import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Stream<int> counterStreamSource() async* {
  for (int i = 0; i <= 10; i++) {
    await Future.delayed(const Duration(seconds: 2));

    yield i + 1;
  }
}

void main() {
  runApp(
    StreamProvider<int>(
      create: (_) => counterStreamSource(),
      initialData: 0,
      child: const SPMyApp(),
    ),
  );
}

class SPMyApp extends StatelessWidget {
  const SPMyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final value = context.watch<int>();

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('$value', style: const TextStyle(fontSize: 45)),
        ),
      ),
    );
  }
}

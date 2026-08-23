import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<String> fetchUserName() async {
  await Future.delayed(Duration(seconds: 2));
  return 'Shinu A Gumaste';
}

void main() {
  runApp(
    FutureProvider(
      create: (_) async => fetchUserName(),
      initialData: 'Loading...',
      child: const FPMyApp(),
    ),
  );
}

class FPMyApp extends StatelessWidget {
  const FPMyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final name = context.watch<String>();

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('$name', style: const TextStyle(fontSize: 20)),
        ),
      ),
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class MyCounterApp extends StatelessWidget{
  const MyCounterApp({super.key});

  @override
  Widget build(BuildContext context) { // Used to render the UI.
    return MaterialApp(
      title: 'Counter App Demo',
      debugShowCheckedModeBanner: false, // Used to ckeck that the Application is running in development Stage or Production Stage.
      theme: ThemeData(
          primarySwatch: Colors.teal
      ),
      home: const CounterPage(),

    );

  }
}
class CounterPage extends StatefulWidget{
  const CounterPage({super.key});

  @override
  State<StatefulWidget> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage>{
  int _counter=0;
  final max_range=50; // Maximum Range WIll be 50.

  void _incrementValue() {
    if(_counter<max_range){
      setState(() {
        _counter++;
      });
    }
  }

  void _resetValue(){
    setState(() {
      _counter=0;
    });
  }

  void _decrementValue(){
    if(_counter>0){
      setState(() {
        _counter--;
      });
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Home', style: TextStyle(color: Colors.red),),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('COUNTER VALUE'), SizedBox(height: 18,), Text('$_counter', style: TextStyle(fontSize: 50),),SizedBox(height: 18,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ElevatedButton(onPressed: (_decrementValue), child: Text('-')),
                SizedBox(width: 18,),
                ElevatedButton(onPressed: (_resetValue), child: Text('RESET')),SizedBox(width: 18,),
                ElevatedButton(onPressed: (_incrementValue), child: Text('+'))],
            )
          ],),
      ),
    );
  }
}

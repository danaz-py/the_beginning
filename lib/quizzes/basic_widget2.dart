import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp()); //this is the commnad that actually runs the thing
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override //you forgot the override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  var _counter = 0;
  var name = 'Dana';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ElevatedButton(
          onPressed: () {
            setState(() {
              _counter++;
            });
          },
          child: Text('$name, You have pressed the button $_counter times.'),
        )
      ),
    );
  }
}
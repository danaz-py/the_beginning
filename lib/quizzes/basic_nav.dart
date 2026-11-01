import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: FirstScreen()));
}

//first screen
class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(appBar: 
      AppBar(
        title: const Text('Page 1')
      ),
        body: Center(
          child: ElevatedButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SecondScreen()));
          }, 
          child: Text("Go to Page 2")),
        )
      )
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(appBar: AppBar(
        title: const Text('Page 2')
        ),
        body: Center(
          child: ElevatedButton(onPressed: () {
            Navigator.pop(context);
          }, 
          child: Text("Go to Page 1")),
        )
      )
    );
  }
}
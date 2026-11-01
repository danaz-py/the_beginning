import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp()); //this is the commnad that actually runs the thing
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override //you forgot the override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold( //OTHERWISE THERES A YELLOW LINE BENEATH TEXT??
        body: Center(
          child: Container(
            height: 350,
            width: 350,
            color: const Color.fromARGB(255, 219, 255, 213),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40, left: 20, top: 10, right: 40),
              child: GestureDetector(
                onTap: () => print("Tapped!"),
                child: const Text(
                  'Tap me',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 80),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

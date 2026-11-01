import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp()); //this is the commnad that actually runs the thing
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override //you forgot the override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column( //why is this centered?
            children: [
              Text('Hello, Flutter!'),
              Text('My name is Dana!'),
              Text('I am learning Flutter!'),
              Text('Flutter is awesome!', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blue)),
              Row( //how do u center this? FIXED
                mainAxisAlignment: MainAxisAlignment.center, //DIS HOW U FIX IT
                children: [
                Container(color: Colors.red[100], padding: EdgeInsets.all(8),
                child: Text('Red', style: TextStyle(color: Colors.red)), 
                  ),
                Container(color: Colors.green[100], padding: EdgeInsets.all(8),
                child: Text('Green', style: TextStyle(color: Colors.green)),
                  ),
                Container(color: Colors.blue[100], padding: EdgeInsets.all(8),
                child: Text('Blue', style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
              Container(
                height: 100, width: 200, color: Colors.red, padding: EdgeInsets.all(20),
                child: Center(child: Text('Hello, Flutter!'))
              ),
              SizedBox(
                height: 150, //so u make a bigger size
                child: Column(mainAxisAlignment: MainAxisAlignment.end, //its not at the bottom doe..
                //the column is only as big as the content within
                children: 
                [
                  Text('1'),
                  Text('2'),
                  Text('3'),
                ],
                ),
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Title'),
                Text('This is some longer text'),
                Text('button'),
              ] 
              ),
              Container(child: Image.asset('assets/images/cat.png')
              ),
            ], //CHILDRen
          ),
        ),
      ),
    );
  }
}

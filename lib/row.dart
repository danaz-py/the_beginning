import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp()); //this is the commnad that actually runs the thing
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //gets rid of the banner
      home: Scaffold(
        body: Center( 
          // center is a single child widget
          child: Container(
            color: Colors.green,
            height: double.infinity,
            child: Row( //without the mainAxis alignment its on the left
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min, //but this makes it take as little space as possible
              crossAxisAlignment: CrossAxisAlignment.center, //it like shifts the things idkk
              children: [ //children can have multiple childs
                Container(
                  //color: Colors.amber,
                  height: 100,
                  width: 100,
                  padding: EdgeInsets.all(25), 
                  margin: EdgeInsets.all(25), 
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color:
                        Colors.amber, 
                  ),
                ),
                Container( //see multiple containers aka widgets within
                  height: 100,
                  width: 100,
                  padding: EdgeInsets.all(20), 
                  margin: EdgeInsets.all(20), 
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color:
                        Colors.amber,) 
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

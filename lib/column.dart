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
            child: Column( //without the mainAxis alignment it's just at the top
            //columns take as much space as possible vertically
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min, //but this makes it take as little space as possible
              children: [ //children can have multiple childs
                Container(
                  //color: Colors.amber,
                  height: 100,
                  width: 100,
                  padding: EdgeInsets.all(25), //PADDING VS MARGIN
                  margin: EdgeInsets.all(25), //margin is outside, padding is inside
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color:
                        Colors.amber, //ERROR without adding color, read the error msg
                  ),
                ),
                Container( //see multiple containers aka widgets within
                  height: 100,
                  width: 100,
                  padding: EdgeInsets.all(20), //PADDING VS MARGIN
                  margin: EdgeInsets.all(20), //margin is outside, padding is inside
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color:
                        Colors.amber, //ERROR without adding color, read the error msg
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

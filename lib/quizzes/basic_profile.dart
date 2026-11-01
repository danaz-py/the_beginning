import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp()); //this is the commnad that actually runs the thing
}

class MainApp extends StatelessWidget{
  const MainApp({super.key});
  
  final String name = 'Jerana';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
        title: Text('My Profile'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(108, 119, 6, 6), //why is it whitewashed
        foregroundColor: Color.fromARGB(255, 255, 255, 255),
        ),
        body: Column(children: 
        [
          Center(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
            radius: 50, 
            backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png')),
          )
          ),
          Text(name),
          Text('Flutter Learner'),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Edit Profile'),
          )
        ],
        )
      )
    );
  }
}
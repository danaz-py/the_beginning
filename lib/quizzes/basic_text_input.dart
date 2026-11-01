import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    //in order to actually read the input
    TextEditingController controller = TextEditingController();
    //that will return controller.text


    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: controller,
                decoration: InputDecoration(labelText: 'Enter your name'),
              ),
              ElevatedButton(onPressed: () {
                //a button for the user to submit
                //you can also store it into a varibale
                String name = controller.text;
                print("hello, $name");
              }, 
              child: const Text("Submit")
              )
            ],
          ),
        ), //gives a box where a user cna type
      ),
    );
  }
}

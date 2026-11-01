import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool isOn = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          width: double.infinity, //HA I CNETERED IT ALONE
          color: const Color.fromARGB(255, 75, 20, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Is it true or false?: $isOn",
                style: TextStyle(color: Colors.white),
              ),
              Text(
                "Turn that shit back ${!isOn}",
                style: TextStyle(color: Colors.white),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () {
                  setState(() {
                    if (isOn == false) {
                      isOn = true;
                      //Text("is it on os off? : $isOn"); //ts doesnt print
                      //its a widget object its not in yo tree
                    } else {
                      isOn = false;
                    }
                  });
                },
                child: Text(
                  "Switch ON/OFF",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 75, 20, 20),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

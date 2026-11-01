import 'package:flutter/material.dart';

void main() {
  runApp(const MoodTracker());
}

class MoodTracker extends StatefulWidget {
  const MoodTracker({super.key});

  @override
  State<MoodTracker> createState() => _MoodTrackerState();
}

class _MoodTrackerState extends State<MoodTracker> {
  String mood = 'None';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Mood Tracker', style: TextStyle(fontSize: 35)),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.all(20),
                  ),
                  onPressed: () {
                    setState(() {
                      mood = 'Happy';
                    });
                  },
                  child: Text('Happy', style: TextStyle(color: Colors.white)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.all(20),
                  ),
                  onPressed: () {
                    setState(() {
                      mood = 'Sad';
                    });
                  },
                  child: Text('Sad', style: TextStyle(color: Colors.white)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.all(20),
                  ),
                  onPressed: () {
                    setState(() {
                      mood = 'Angry';
                    });
                  },
                  child: Text('Angry', style: TextStyle(color: Colors.white)),
                ),
              ),
              // if (mood == 'Angry')
              //   Text('Current Mood: $mood', style: TextStyle(fontSize: 30, color: Colors.red))
              // else if (mood == 'Happy')
              //   Text('Current Mood: $mood', style: TextStyle(fontSize: 30, color: Colors.green))
              // else
              //   Text('Current Mood: $mood', style: TextStyle(fontSize: 30, color: Colors.blue))
              Text(
                'Current Mood: $mood',
                style: TextStyle(
                  fontSize: 30,
                  color:
                      {'Angry': Colors.red, 
                      'Happy': Colors.green}
                      [mood] ??Colors.blue, // Defaults to blue for neutral/other
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

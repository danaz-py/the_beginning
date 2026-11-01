import 'package:flutter/material.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  int question = 1;
  int score = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Quiz App')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (question < 4) 
                Text('Question $question / 3'),
              if (question == 1) ...[
                Text('What is 2+2?'),
                ElevatedButton(
                  onPressed: () {
                    score;
                    question++;
                    setState(() {});
                  },
                  child: Text('3'),
                ),
                ElevatedButton(
                  onPressed: () {
                    score++;
                    question++;
                    setState(() {});
                  },
                  child: Text('4'),
                ),
                ElevatedButton(
                  onPressed: () {
                    score;
                    question++;
                    setState(() {});
                  },
                  child: Text('5'),
                ),
              ] else if (question == 2) ...[
                Text('Which language does Flutter primarily use?'),
                ElevatedButton(
                  onPressed: () {
                    score++;
                    question++;
                    setState(() {});
                  },
                  child: Text('Dart'),
                ),
                ElevatedButton(
                  onPressed: () {
                    score;
                    question++;
                    setState(() {});
                  },
                  child: Text('Java'),
                ),
                ElevatedButton(
                  onPressed: () {
                    score;
                    question++;
                    setState(() {});
                  },
                  child: Text('Python'),
                ),
              ] else if (question == 3) ...[
                Text('Which widget is used to make a button?'),
                ElevatedButton(
                  onPressed: () {
                    score;
                    question++;
                    setState(() {});
                  },
                  child: Text('Padding'),
                ),
                ElevatedButton(
                  onPressed: () {
                    score;
                    question++;
                    setState(() {});
                  },
                  child: Text('Container'),
                ),
                ElevatedButton(
                  onPressed: () {
                    score++;
                    question++;
                    setState(() {});
                  },
                  child: Text('ElevatedButton'),
                ),
              ] else ...[
                Text('Quiz Done!'),
                Text('Score: $score/3'),
                ElevatedButton(onPressed: () {
                  setState(() {
                    question = 1;
                    score = 0;
                  });
                }, child: Text('Try Again'))]
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

//BONUS ADD A SHUFFLE BUTTON THAT RNADOMZIES THE FLASHCARDS

void main() {
  runApp(const MaterialApp(home: FlashcardApp()));
}

class FlashcardApp extends StatefulWidget {
  const FlashcardApp({super.key});

  @override
  State<FlashcardApp> createState() => _FlashcardAppState();
}

class _FlashcardAppState extends State<FlashcardApp> {
  List<Map<String, dynamic>> flashcards = [
    {
      "question": "What programming language does Flutter use?",
      "answer": "dart",
    },
    {
      "question": "Why did the chicken cross the road?",
      "answer": "To get to the other side",
    },
    {"question": "What is AIDs in spanish", "answer": "el SIDA"},
    {"question": "Como se llama", "answer": "Me llamo guapo"},
    {"question": "LOVE ME LOVE ME", "answer": "HATE ME HATE ME"},
  ];

  var flashcardNumber = 0;
  var showAnswer = false;
  var score = 0;
  List<int> correctCards = [];
  double get progress => (flashcardNumber + 1)/flashcards.length;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Flashcards")),
        body: Center(
          child: Column(
            children: [
              Text("Card ${flashcardNumber+1} of ${flashcards.length}"),
              LinearProgressIndicator(value: progress),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  color: const Color.fromARGB(255, 198, 237, 255),
                  height: 200,
                  width: 300,
                  child: showAnswer
                      ? Text(flashcards[flashcardNumber]["answer"]) //if true
                      : Text(flashcards[flashcardNumber]["question"]), //else
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    showAnswer = !showAnswer;
                  });
                },
                child: showAnswer
                    ? Text("Hide Answer")
                    : Text("Show Answer"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(onPressed: () {
                  if (!correctCards.contains(flashcardNumber)) {
                    //if it doesnt contain it
                    score++;
                    correctCards.add(flashcardNumber);
                  }
                }, child: Text('I know it')),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(onPressed: () {
                    setState(() {
                      flashcardNumber--;
                    });
                  }, child: Icon(Icons.arrow_back)),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (flashcardNumber < flashcards.length - 1) {
                        setState(() {
                          flashcardNumber++;
                          showAnswer = false;
                        });
                      } else {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EndScreen(
                              final_score: score,
                              num_flashcards: flashcards.length,
                            ),
                          ),
                        );

                        if (result != null) {
                          setState(() {
                            flashcardNumber = result['currentCard'];
                            score = result['initialScore'];
                            showAnswer = result['showAnswer'];
                            correctCards.clear();
                          });
                        }
                      }
                    },
                    child: Icon(Icons.arrow_forward),
                  ),
                )
              ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EndScreen extends StatelessWidget {
  final int final_score;
  final int num_flashcards;
  const EndScreen({super.key, required this.final_score, required this.num_flashcards});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Flashcards Compelted')),
        body: Center(
          child: Column(
            children: [
              Text("Score: $final_score/$num_flashcards"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(onPressed: () {
                  Navigator.pop(context, {
                    'currentCard':0,
                    'initialScore':0,
                    'showAnswer': false,
                  });
                }, child: Text("Restart")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
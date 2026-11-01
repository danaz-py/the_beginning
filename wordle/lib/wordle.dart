import 'package:flutter/material.dart';
import 'package:wordle/game.dart'; //legal words and legal guesses sbs

void main() {
  //entry point
  runApp(const MainApp()); //runApp takes widget as argument, we pass in MainApp
  //makes MainApp the root of the widget tree
}

//MainApp is a root widget, passed into runApp
//within this widget there is a build method that returns
//another widget called MaterialApp
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //got rind of const when we added scaffold why?
      //mainapp is the root, material app below, then scaffold below
      //scafold splits into 2 sub seeds, AppBar and Center
      home: Scaffold(
        //provides material style page layout
        appBar: AppBar(
          //creates an app bar
          title: Align(alignment: Alignment.center, child: Text("Wordle")),
        ),
        body: Center(child: GamePage()),
      ),
    );
  }
}

//stateless is immutable
//these is the 5 words
// _ _ _ _ _ x 5
class Tile extends StatelessWidget {
  //new widget tILE
  const Tile(this.letter, this.hitType, {super.key});

  //constructure: defines what data needs to be passed into
  //here we need a String letter and HitType an enum value
  //the widget to render the widget
  final String letter; //guessed letter of the tile
  final HitType hitType; //enum value to represent guess result
  //constructures make widgets reusable

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer( //make it aniamted
      //conven ience widget that wraps several core styling widgets
      //like padding, sized box, decorated box
      duration: Duration(milliseconds: 1000), //required property
      curve: Curves.bounceIn,
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        //pretty usefull
        border: Border.all(color: Colors.grey),
        color: switch (hitType) {
          //switch is cool
          HitType.hit => Colors.green,
          HitType.partial => Colors.yellow,
          HitType.miss => Colors.grey,
          _ => Colors.white,
        },
      ),

      //child property contains a widget
      child: Center(
        child: Text(
          letter.toUpperCase(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}

//display UI elemeents
//https://docs.flutter.dev/learn/pathway/tutorial/layout
class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> { //extends the state
  //hold mutable state and build method
    final Game _game = Game();
    //whena. user makes a guess, the word is save don Game object
    //which is a prop of the GamePage class
    //therefore is a state that might change and require the UI to update
  
    @override
    Widget build(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          spacing: 5,
          children: [
            for (final guess in _game.guesses) //5 game guesses
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, //make it in the center
                spacing:
                    5, //1 guess is tech 1 letter and there are 5 letters per guess
                children: [
                  for (final letter in guess) Tile(letter.char, letter.type),
                ],
              ),
            GuessInput(
              //THIS IS THE CALLBACK FUNCTION THAT IS PASSED INTO THE GUESSINPUT WIDGET
              onSubmitGuess: (String guess) {
                setState(() { //signal to flutter that the state of the widget has changed and it needs to rebuild the UI
                  _game.guess(guess); //if u were to call this WITHOUT setstate
                  //the itnernal game data would change but it wouldnt change the UI
                });
              },
            )
          ],
        ),
      );
    }
  }

//dedicated widget for users to type in their guesses
class GuessInput extends StatelessWidget {
  //runs whenever smeoen creaates this widget
  GuessInput({super.key, required this.onSubmitGuess});
  //requires a callback function to be passed in when the widget is created

  final void Function(String) onSubmitGuess;
  //declares final member of the class called onSubmitGuess that has the type
  //voidFunction(String). This func takes a single String arg (user's guess)
  //and doesn't return any value, denoted by void

  final TextEditingController _textEditingController = TextEditingController();
  //used to read, clear and modify the text in a textfield 
  //to use it pass it into the textfield

  final FocusNode _focusNode = FocusNode();
  //request a TextField to gain focus
  //after you press enter, you can continue to type

  void _onSubmit() { //helper function
    onSubmitGuess(_textEditingController.text);
    //this argument accepts a callback and the callback is triggered whenere the user
    //presses enter key
    _textEditingController.clear();
    _focusNode.requestFocus();
    //A FocusNode gives you control over focus, 
    //and calling requestFocus() moves focus to its associated widget.
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox( //GIVES IT A FIXED SIZE
        //expanded tells the child to fill all the available space along the main axis
        //horizontal for row, vertical for column
        //textfield stretch up to take up all the space except whats taken by other widgets
        //expanded is often the solution to unbounded width/height exceptions
          width:300,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField( //basic widget for text input
              maxLength: 5, //only 5 letters
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                ),
              ),
              controller: _textEditingController,
              //when a user inputs text it captures it on _textEditingController
              autofocus: true, //gain focus without user taking action
              focusNode: _focusNode,
              onSubmitted: (input) {
                _onSubmit();
              },
            ),
          ),
        ),
        IconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.arrow_circle_up),
          onPressed: _onSubmit,
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'movie.dart';

void main() {
  runApp(const MaterialApp(home: MovieWatchList()));
}

class MovieWatchList extends StatefulWidget {
  const MovieWatchList({super.key});

  @override
  State<MovieWatchList> createState() => MovieWatchlistState();
}

class MovieWatchlistState extends State<MovieWatchList> {
  var myMovies = MovieList();
  var myActualMovies = <Movie>[]; //master list
  TextEditingController searchController = TextEditingController();
  List<bool> _selections = [true, false, false];

  @override
  void initState() {
    super.initState();
    myMovies.addMovie(
      Movie(
        name: "Black Panther",
        year: 2018,
        genre: "Fantasy",
        watched: false,
      ),
    );
    myActualMovies.add(
      Movie(
        name: "Black Panther",
        year: 2018,
        genre: "Fantasy",
        watched: false,
      ),
    );
    myMovies.addMovie(
      Movie(name: "Healed Arm", year: 2026, genre: "Realistic", watched: true),
    );
    myActualMovies.add(
      Movie(name: "Healed Arm", year: 2026, genre: "Realistic", watched: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AllMovies = myActualMovies
        .where(
          (movie) => movie.name.toLowerCase().contains(
            searchController.text.toLowerCase(),
          ),
        )
        .toList();

    var filteredMovies = AllMovies;
    if (_selections[1] == true) {
      // Unwatched
      filteredMovies = AllMovies.where(
        (movie) => movie.watched == false,
      ).toList();
    } else if (_selections[2] == true) {
      // Watched
      filteredMovies = AllMovies.where(
        (movie) => movie.watched == true,
      ).toList();
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Movie Watchlist")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                //give me all movies wehere watched is true
                "${myActualMovies.where((movie) => movie.watched).length} / ${myActualMovies.length} watched",
              ),
              //filter
              ToggleButtons(
                children: [Text('All'), Text('Unwatched'), Text('Watched')],
                isSelected: _selections,
                onPressed: (int index) {
                  setState(() {
                    // Make every button false
                    _selections = [false, false, false];

                    // Make the button that was clicked true
                    _selections[index] = true;
                  });
                },
              ),
              //search bar
              TextField(
                controller: searchController,
                decoration: InputDecoration(hintText: "Search Movies"),
                onChanged: (value) {
                  setState(() {});
                },
              ),
              //filter w toggle buttons
              //By default, toString() just returns "Instance of 'Movie'".
              //so i added a override
              Expanded(
                child: ListView.builder(
                  itemCount: filteredMovies.length,
                  itemBuilder: (context, index) {
                    final oneMovie = filteredMovies.elementAt(index);
                    return CheckboxListTile(
                      title: Text(oneMovie.toString()),
                      value: oneMovie.watched,
                      onChanged: (bool? newValue) {
                        setState(() {
                          myMovies.completeMovie(oneMovie);
                          oneMovie.watched = newValue ?? false;
                        });
                      },
                      secondary: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            myActualMovies.remove(oneMovie);
                            myMovies.removeMovie(oneMovie);
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    final newMovie = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => addMovieScreen()),
                    );
                    if (newMovie != null) {
                      setState(() {
                        String newMovieName = newMovie[0];
                        int newMovieYear = int.tryParse(newMovie[1]) ?? 0;
                        String newMovieGenre = newMovie[2];

                        myMovies.addMovie(
                          Movie(
                            name: newMovieName,
                            year: newMovieYear,
                            genre: newMovieGenre,
                            watched: false,
                          ),
                        );
                        myActualMovies.add(
                          Movie(
                            name: newMovieName,
                            year: newMovieYear,
                            genre: newMovieGenre,
                            watched: false,
                          ),
                        );
                      });
                    }
                  },
                  child: Text('Add Movie'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class addMovieScreen extends StatelessWidget {
  addMovieScreen({super.key}); //not const cs sum actually does change
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerYear = TextEditingController();
  TextEditingController controllerGenre = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Text('Movie Name'),
            SizedBox(
              height: 80,
              width: 250,
              child: TextField(controller: controllerName),
            ),
            Text('Movie Year'),
            SizedBox(
              height: 80,
              width: 250,
              child: TextField(controller: controllerYear),
            ),
            Text('Movie Genre'),
            SizedBox(
              height: 80,
              width: 250,
              child: TextField(controller: controllerGenre),
            ),
            ElevatedButton(
              onPressed: () {
                if (controllerName.text.isNotEmpty &&
                    controllerYear.text.isNotEmpty &&
                    controllerGenre.text.isNotEmpty) {
                  List<dynamic> newMovie = [
                    controllerName.text,
                    controllerYear.text,
                    controllerGenre.text,
                  ];
                  Navigator.pop(context, newMovie);
                }
              },
              child: Text('Add Movie'),
            ),
          ],
        ),
      ),
    );
  }
}

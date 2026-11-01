class Movie {
  final String name;
  final int year;
  final String genre;
  bool watched;

  Movie({
    required this.name,
    required this.year,
    required this.genre,
    required this.watched
  });

  @override
  String toString() {
    return '$name • $year  • $genre';
  }
}

class MovieList {
  final List<dynamic> all_movies = [];

  void addMovie(Movie movie) {
    all_movies.add(movie);
  }

  void removeMovie(Movie movie) {
    all_movies.remove(movie);
  }
  
  void completeMovie(Movie movie) {
    movie.watched = !movie.watched;
  }

  List<dynamic> get movies => List<dynamic>.from(all_movies);
}
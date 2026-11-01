// import 'package:flutter/material.dart';
// import 'movie.dart';
// import 'movie_watchlist.dart';

// void main() {
//   runApp(const SearchBar());
// }

// class SearchBar extends StatefulWidget {
//   const SearchBar({super.key});

//   @override
//   State<SearchBar> createState() => _SearchBarState();
// }

// class _SearchBarState extends State<SearchBar> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: IconButton(
//             onPressed: () {
//               showSearch(
//                 context: context,
//                 delegate: CustomSearchDelegate(),
//               );
//             },
//             icon: const Icon(Icons.search),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CustomSearchDelegate extends SearchDelegate {
//   final List<String> searchTerms = searchMovieName();

//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         onPressed: () {
//           query = ''; //clears it
//         },
//         icon: const Icon(Icons.clear),
//       ),
//     ];
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//       onPressed: () {
//         //lets u exit out of the search
//         close(context, null);
//       },
//       icon: const Icon(Icons.arrow_back),
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     List<String> matchQuery = [];
//     for (var food in searchTerms) {
//       if (food.toLowerCase().contains(query.toLowerCase())) {
//         matchQuery.add(food);
//       }
//     }
//     return ListView.builder(
//       itemCount: matchQuery.length,
//       itemBuilder: (context, index) {
//         var result = matchQuery[index];
//         return ListTile(title: Text(result));
//       },
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     List<String> matchQuery = [];
//     for (var food in searchTerms) {
//       if (food.toLowerCase().contains(query.toLowerCase())) {
//         matchQuery.add(food);
//       }
//     }
//     return ListView.builder(
//       itemCount: matchQuery.length,
//       itemBuilder: (context, index) {
//         var result = matchQuery[index];
//         return ListTile(title: Text(result));
//       },
//     );
//   }
// }

// class searchMovieName {
//   //what the fuck?
//   static List<Movie> filterByName(List<Movie> movieList, String targetName) {
//     List<Movie> matchingMovies = [];

//     for (var movie in movieList) {
//       // Check if movie name contains target text (case-insensitive)
//       if (movie.name.toLowerCase().contains(targetName.toLowerCase())) {
//         matchingMovies.add(movie);
//       }
//     }

//     return matchingMovies;
//   }
// }
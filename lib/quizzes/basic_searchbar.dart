import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: BasicSearchbar(),
  ));
}

class BasicSearchbar extends StatefulWidget {
  const BasicSearchbar({super.key});

  @override
  State<BasicSearchbar> createState() => _BasicSearchBarState();
}

class _BasicSearchBarState extends State<BasicSearchbar> {
  //const _BasicSearchBarState({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ),
      );
  }
}

//searchdelagte is an actual thing
class CustomSearchDelegate extends SearchDelegate {
  final List<String> searchTerms = [
    "Apple",
    "Banana",
    "Chili",
    "Healed",
    "Oranges",
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = ''; //clears it
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        //lets u exit out of the search
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var food in searchTerms) {
      if (food.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(food);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(title: Text(result));
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var food in searchTerms) {
      if (food.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(food);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(title: Text(result));
      },
    );
  }
}

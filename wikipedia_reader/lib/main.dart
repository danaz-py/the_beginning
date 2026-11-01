import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'summary.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: ArticleView());
    //This change switches from the console-based test to the full UI experience with proper state management.

    // //instanitate your view model and pass it to the widget tree,
    // //so that it can be accessed by the widgets that need it.
    // final viewModel = ArticleViewModel(ArticleModel());
    // return MaterialApp(
    //   home: Scaffold(
    //     appBar: AppBar(title: const Text('Wikipedia Reader')),
    //     body: const Center(child: Text('loading...')),
    //   ),
    // );
  }
}

//defining the model: the source of truth for the app,
//which is the data that the app will use to make http requests and display the results.
class ArticleModel {
  Future<Summary> getRandomArticleSummary() async {
    //async marks a method as synchronous,
    //meaning it can perform asynchronous operations and return a Future.
    //The Future represents a value that will be available at some point in the future,
    //allowing the method to perform tasks that may take time,
    //such as making network requests, without blocking the execution of the program.
    final uri = Uri.https(
      'en.wikipedia.org',
      '/api/rest_v1/page/random/summary',
    );
    //Uri.https constructure safely builds urls by handling encoding and formatting
    final response = await http.get(
      uri,
    ); //waits for expressions that return a future

    if (response.statusCode == 200) {
      return Summary.fromJson(jsonDecode(response.body));
    } else {
      throw const HttpException('Failed to load article summary');
    }
  }
}

class ArticleViewModel extends ChangeNotifier {
  final ArticleModel model; //holds three pieces of state
  Summary? summary; //current wikipedia article data
  Exception? error; //any error that occurs while fetching the data
  bool isLoading = false; //flag to show progress indicators

  ArticleViewModel(this.model) {
    fetchArticle(); //fetches a random article when the view model is created
  }

  Future<void> fetchArticle() async {
    isLoading = true;
    notifyListeners(); //notifies the listeners that the state has changed
    //try catch block to gracefully handle network errors and update the UI accordingly
    //clears previous errors on success and clears preious article summary on error
    try {
      summary = await model.getRandomArticleSummary();
      print('Fetched article summary: ${summary!.titles.normalized}');
      error = null; //clear any prev errors
    } on HttpException catch (e) {
      print('Error fetching article summary: ${e.message}');
      error = e;
      summary = null;
    }
    isLoading = false;
    notifyListeners();
  }
}

class ArticleView extends StatefulWidget {
  const ArticleView({super.key});

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

//wait why again?
class _ArticleViewState extends State<ArticleView> {
  final ArticleViewModel viewModel = ArticleViewModel(ArticleModel());

  @override
  void initState() {
    super.initState();
    viewModel
        .fetchArticle(); //fetches a random article when the view model is created
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wikipedia Reader')),
      body: ListenableBuilder(
        //uses builder pattern which requires a callback rather than a child widget
        //these widgets are flexible bc u can perform operaitons withthin the callback
        listenable: viewModel,
        builder: (context, _) {
          return switch ((
            viewModel.isLoading,
            viewModel.summary,
            viewModel.error,
          )) {
            (true, _, _) => const Center(child: CircularProgressIndicator()),
            (_, _, final Exception e) => Center(
              child: Text('Error: ${e.toString()}')),
            (_, final summary?, _) => ArticlePage(
              summary: summary,
              nextArticleCallback: () => viewModel.fetchArticle(),
            ),
            _ => const Center(child: Text('No data available')),
          };
        },
      ),
    );
  }
}

//displays the actual article content
class ArticlePage extends StatelessWidget {
  const ArticlePage({
    super.key,
    required this.summary,
    required this.nextArticleCallback,
  });

  final Summary summary;
  final VoidCallback nextArticleCallback;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ArticleWidget(summary: summary),
          ElevatedButton(
            onPressed: nextArticleCallback,
            child: const Text('Next Article'),
          ),
        ],
      ),
    );
  }
}

class ArticleWidget extends StatelessWidget {
  const ArticleWidget({super.key, required this.summary});

  final Summary summary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        spacing: 10,
        children: [
        if (summary.hasImage) ...[
          Text(
            summary.titles.normalized,
            overflow: TextOverflow.ellipsis, //prevents text from breaking the layout.
            style: Theme.of(context).textTheme.displaySmall,
          ),
          if (summary.description != null)
            Text(
              summary.description!,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          Text(summary.extract),
          ]
        ],
      ),
    );
  }
}

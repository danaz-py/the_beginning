import 'package:flutter/material.dart';

void main() {
  runApp(const BasicGroceryapp());
}

class BasicGroceryapp extends StatefulWidget {
  const BasicGroceryapp({super.key});

  @override
  State<BasicGroceryapp> createState() => _BasicGroceryappState();
}

class _BasicGroceryappState extends State<BasicGroceryapp> {
  final List<String> total_items = [
    'Salmon',
    'Milk',
    'Bread',
    'Sugar',
    'Oranges',
  ];
  List<String> visible_items = ['2 dozen eggs', 'caviar'];

  int current_index = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Grocery List')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var item in visible_items)
                ...[
                  Text(item, style: TextStyle(fontSize: 18)),
                  Text('---------------------------------------'),
                ],
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (visible_items.length <= total_items.length) {
                      visible_items.add(total_items[current_index]);
                      current_index++;
                    }
                  });
                },
                child: Text('Add item'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

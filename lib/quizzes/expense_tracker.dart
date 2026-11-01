import 'package:flutter/material.dart';

void main() {
  runApp(const ExpenseTracker());
}

class ExpenseTracker extends StatefulWidget {
  const ExpenseTracker({super.key});

  @override
  State<ExpenseTracker> createState() => _ExpenseTrackerState();
}

class _ExpenseTrackerState extends State<ExpenseTracker> {
  List<String> expenseNames = ["Oreos", "G2 Pen"];
  List<double> expenseAmounts = [6.99, 3.99];
  double get total =>
      expenseAmounts.fold(0.0, (prev, element) => prev + element);
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerPrice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Expense Tracker")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("Expense", style: TextStyle(fontSize: 20)),
                  ),
                  SizedBox(
                    //make it not huge
                    height: 80,
                    width: 200,
                    child: TextField(
                      controller: controllerName,
                      decoration: InputDecoration(),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text('Price', style: TextStyle(fontSize: 20)),
                  ),
                  SizedBox(
                    height: 80,
                    width: 200,
                    child: TextField(
                      controller: controllerPrice,
                      decoration: InputDecoration(),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(150, 60),
                ),
                onPressed: () {
                  setState(() {
                    
                    if (double.tryParse(controllerPrice.text) == null) {
                      print("Please enter a valid price");
                    } else {
                      double expenseNewprice = double.parse(
                        controllerPrice.text,
                      ); //is it a dlouble?
                      expenseAmounts.add(expenseNewprice);
                      String expenseNew = controllerName.text;
                    expenseNames.add(expenseNew);
                    }
                    
                    // print(expenseNames);
                    // print(expenseAmounts);
                  });
                },
                child: Text("Add Expense"),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text("Current Expenses", style: TextStyle(fontSize: 20)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20, bottom: 8),
                    child: Column(
                      children: [
                        for (var expense in expenseNames) ...[
                          Text(expense, style: TextStyle(fontSize: 15)),
                        ],
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, bottom: 8.0),
                    child: Column(
                      children: [
                        for (double expensePrice in expenseAmounts) ...[
                          Text(
                            expensePrice.toString(),
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      for (var i = 0; i < expenseNames.length; i++) ...[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(8, 2)
                            ),
                            onPressed: () {
                              setState(() {
                                expenseNames.removeAt(i);
                                expenseAmounts.removeAt(i);
                              });
                            },
                            child: Text('Delete'),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
              Text('___________________________________________'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text('Total:'),
                  ),
                  Text("$total"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

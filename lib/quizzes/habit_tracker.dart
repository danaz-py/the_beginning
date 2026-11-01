import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: HabitTracker()));
}

class HabitTracker extends StatefulWidget {
  const HabitTracker({super.key});

  @override
  State<HabitTracker> createState() => _HabitTrackerState();
}

class _HabitTrackerState extends State<HabitTracker> {
  List<Map<String, dynamic>> habits = [
    {"name": "Study Flutter", "completed": false},
    {"name": "Exercise", "completed": true},
  ];

  //nicce syntax that i ai'ed
  int get completedHabits => habits
      .where((habit) => habit["completed"] == true)
      .length;

  double get progress => completedHabits.toDouble()/habits.length;
  //since completed habits is a get

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('My Habits')),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('$completedHabits/${habits.length} Completed'),
            LinearProgressIndicator(value: progress),
            Expanded(
              //otherwise it wont work under a column
              //but it was also put the buttona t the bottom
              child: ListView.builder(
                itemCount: habits.length,
                itemBuilder: (context, index) {
                  final habit = habits[index];
                  return CheckboxListTile(
                    title: Text(habit["name"]),
                    value: habit["completed"],
                    onChanged: (bool? newValue) {
                      setState(() {
                        habits[index]["completed"] = newValue ?? false;
                      });
                    },
                    //seocndayr adds a shit next to it like in a row
                    secondary: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        habits.removeAt(index);
                      });
                    },
                  ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(minimumSize: const Size(200,60)),
                onPressed: () async {
                  final newHabit = await Navigator.push<String>(context, MaterialPageRoute(builder: (context) => AddHabit()));
                  if (newHabit != null && newHabit.isNotEmpty) {
                    setState(() {
                    habits.add({"name": newHabit, "completed": false});
                  });
                  }
                },
                child: Text('+'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddHabit extends StatelessWidget {
  AddHabit({super.key});
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerSets = TextEditingController();
  TextEditingController controllerReps = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Add Habit'),),
        body: Center(
          child: Column(
            children: [
              Text('Exercise Name'),
              SizedBox(
                height: 80,
                width: 250,
                child: TextField(
                  controller: controllerName,
                
                ),
              ),
                            Text('Num of Sets'),
              SizedBox(
                height: 80,
                width: 250,
                child: TextField(
                  controller: controllerSets,
                
                ),
              ),
                                          Text('Num of Reps'),
              SizedBox(
                height: 80,
                width: 250,
                child: TextField(
                  controller: controllerReps,
                
                ),
              ),
              ElevatedButton(onPressed: () {
                if (controllerName.text.isNotEmpty && controllerReps.text.isNotEmpty && controllerSets.text.isNotEmpty)
                {
                  Navigator.pop(context, controllerName.text);
                  //pass in the controller text
                }
                
              }, child: Text('Add Habit'))
          
            ],
          ),
        ),
      ),
    );
  }
}
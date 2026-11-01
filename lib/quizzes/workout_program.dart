import 'package:flutter/material.dart';
import 'store_workout.dart';

//also whenevr i click the chekc box it adds to completed_exes
//also gotta do a workout completion thing

void main() {
  runApp(const MaterialApp(home: WorkoutProgram()));
}

class WorkoutProgram extends StatefulWidget {
  const WorkoutProgram({super.key});

  @override
  State<WorkoutProgram> createState() => _WorkoutProgramState();
}

class _WorkoutProgramState extends State<WorkoutProgram> {
  //call upon
  var myWorkout = WorkoutRoutine(); //CALL THE FUNCITON
  var myExercises = <Exercise>{}; //AHHH YEAH U NEED TO CALL THE LIST
  //var total_sets = 0;
  //var total_exes = 0;
  //var completed_exes = 0;

  @override
  //why? initstate
  void initState() {
    super.initState();

    final benchPress = Exercise(name: 'Bench Press', sets: 3, reps: 10);
    final inclineDumbbellPress = Exercise(
      name: 'Incline Dumbbell Press',
      sets: 4,
      reps: 8,
    );

    //so its lceaner (above)
    myWorkout.addExercise(benchPress);
    myWorkout.addExercise(inclineDumbbellPress);
    myExercises.addAll([benchPress, inclineDumbbellPress]);

    // 2. Assign the total number of exercises
    //total_exes = myWorkout.exercises.length;
  }

  @override
  Widget build(BuildContext context) {
    // Calculate completed exercises dynamically every time build() runs
    final completed_exes = myWorkout.exercises.values
        .where((isCompleted) => isCompleted)
        .length;
    final total_sets = myWorkout.exercises.keys.fold<int>(
      //fold sums it up
      0,
      (sum, exercise) => sum + exercise.sets,
    );
    final total_exes = myWorkout.exercises.length;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Workout Program")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: myExercises.length,
                  itemBuilder: (context, index) {
                    // 1. Get the current Exercise object from your set/list
                    final exercise = myExercises.elementAt(index);

                    // 2. Read the boolean directly from your WorkoutRoutine map
                    final bool isCompleted =
                        myWorkout.exercises[exercise] ?? false;

                    return CheckboxListTile(
                      title: Text(exercise.toString()),
                      value: isCompleted,
                      onChanged: (bool? newValue) {
                        setState(() {
                          // 3. Update the boolean value inside the WorkoutRoutine map
                          myWorkout.toggleExercise(exercise, newValue ?? false);
                        });
                      },
                      secondary: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            myExercises.remove(exercise);
                            //total_exes--;
                            myWorkout.removeExercise(exercise);
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final newExercise = await Navigator.push<List<dynamic>>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddExerciseScreen(),
                    ),
                  );
                  setState(() {
                    if (newExercise != null) {
                      String newExName = newExercise[0];
                      int newExReps = int.tryParse(newExercise[1]) ?? 0;
                      int newExSets = int.tryParse(newExercise[2]) ?? 0;
                      //total_sets += newExSets; //add the sets to the total sets
                      //total_exes++; //then add one more exercise
                      final newEx = Exercise(
                        name: newExName,
                        sets: newExSets,
                        reps: newExReps,
                      );
                      myExercises.add(newEx);
                      myWorkout.addExercise(newEx);
                    }
                  });
                },
                child: Text("Add Exercise"),
              ),
              Text("Total Sets; $total_sets"),
              Text("$completed_exes / $total_exes completed"),
              if (completed_exes == total_exes && total_exes > 0)
              //ONLY APPEARS IF COMPELTED AYY!
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CompletedWorkout(),
                      ),
                    );
                  },
                  child: const Text('Complete Workout'),
                )
,
            ],
          ),
        ),
      ),
    );
  }
}

class AddExerciseScreen extends StatelessWidget {
  AddExerciseScreen({super.key});
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerSets = TextEditingController();
  TextEditingController controllerReps = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Add Exercise')),
        body: Column(
          children: [
            Text('Exercise Name'),
            SizedBox(
              height: 80,
              width: 250,
              child: TextField(controller: controllerName),
            ),
            Text('Num of Sets'),
            SizedBox(
              height: 80,
              width: 250,
              child: TextField(controller: controllerSets),
            ),
            Text('Num of Reps'),
            SizedBox(
              height: 80,
              width: 250,
              child: TextField(controller: controllerReps),
            ),
            ElevatedButton(
              onPressed: () {
                if (controllerName.text.isNotEmpty &&
                    controllerReps.text.isNotEmpty &&
                    controllerSets.text.isNotEmpty) {
                  List<dynamic> newExercises = [
                    controllerName.text,
                    controllerReps.text,
                    controllerSets.text,
                  ];
                  Navigator.pop(context, newExercises);
                  //pass in the controller text
                }
              },
              child: Text('Add Exercise'),
            ),
          ],
        ),
      ),
    );
  }
}

class CompletedWorkout extends StatelessWidget {
  CompletedWorkout({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body:
        Center(child: Column(
          children: [
            Text("Workout Complete!"),
            ElevatedButton(onPressed: () {
              Navigator.pop(context);
            }, child: Text("Retun to Workout"))
          ],
        ),)
      )
    );
  }
}
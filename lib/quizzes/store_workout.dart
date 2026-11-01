//constructor
class Exercise {
  final String name;
  final int sets;
  final int reps;

  // Constructor with named, required parameters for clarity
  Exercise({
    required this.name,
    required this.sets,
    required this.reps,
  });

  @override
  String toString() => '$name: $sets sets x $reps reps';
  //basically just does all the pretty shit for us
}

//actually storing it, using constructor class
class WorkoutRoutine {
  final Map<Exercise, bool> _exercises = {};

  // Add an Exercise object with a default completed status of false
  void addExercise(Exercise exercise) {
    _exercises[exercise] = false;
  }

//why do i gotta creat htese??
//so its removable/modifable 
void removeExercise(Exercise exercise) {
    _exercises.remove(exercise);
  }
  //blud whats goin on
  void toggleExercise(Exercise exercise, bool isCompleted) {
    _exercises[exercise] = isCompleted;
  }
  // // Read-only getter for the exercises
  Map<Exercise, bool> get exercises => Map.unmodifiable(_exercises);
}
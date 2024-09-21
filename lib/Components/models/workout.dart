import 'package:testproject/Components/models/workout_sets.dart';

class Workout {
  String id;
  List<WorkoutSet> sets;

  Workout({required this.id, required this.sets});
}
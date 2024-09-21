import 'package:flutter/cupertino.dart';
import 'package:testproject/Components/models/workout.dart';

class WorkoutProvider with ChangeNotifier {
  List<Workout> _workouts = [];

  List<Workout> get workouts => _workouts;

  void addWorkout(Workout workout) {
    _workouts.add(workout);
    notifyListeners();
  }

  void deleteWorkout(String id) {
    _workouts.removeWhere((workout) => workout.id == id);
    notifyListeners();
  }

  void updateWorkout(String id, Workout updatedWorkout) {
    final index = _workouts.indexWhere((workout) => workout.id == id);
    if (index != -1) {
      _workouts[index] = updatedWorkout;
      notifyListeners();
    }
  }
}
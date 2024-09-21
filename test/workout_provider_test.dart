// test/workout_provider_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:testproject/Components/models/workout.dart';
import 'package:testproject/Components/models/workout_sets.dart';
import 'package:testproject/Components/providers/workout_provider.dart';


void main() {
  group('WorkoutProvider Tests', () {
    WorkoutProvider? workoutProvider; // Made it nullable to avoid potential null issues.

    setUp(() {
      workoutProvider = WorkoutProvider();
    });

    test('Adding a workout should increase the workout count', () {
      final workout = Workout(id: '0', sets: [
        WorkoutSet(exercise: 'Bench press', weight: 50, repetitions: 8)
      ]);
      workoutProvider!.addWorkout(workout);  // Ensure it's not null with !

      expect(workoutProvider!.workouts.length, 1);  // Ensure it's not null with !
    });

    test('Deleting a workout should decrease the workout count', () {
      final workout = Workout(id: '1', sets: [
        WorkoutSet(exercise: 'Bench press', weight: 50, repetitions: 8)
      ]);
      workoutProvider!.addWorkout(workout); // Ensure it's not null with !
      workoutProvider!.deleteWorkout('1');  // Ensure it's not null with !

      expect(workoutProvider!.workouts.length, 0);  // Ensure it's not null with !
    });

    test('Updating a workout should modify its details', () {
      final workout = Workout(id: '1', sets: [
        WorkoutSet(exercise: 'Bench press', weight: 50, repetitions: 8)
      ]);
      workoutProvider!.addWorkout(workout); // Ensure it's not null with !

      final updatedWorkout = Workout(id: '1', sets: [
        WorkoutSet(exercise: 'Squat', weight: 100, repetitions: 10)
      ]);
      workoutProvider!.updateWorkout('1', updatedWorkout);  // Ensure it's not null with !

      expect(workoutProvider!.workouts[0].sets[0].exercise, 'Squat');  // Ensure it's not null with !
    });
  });
}

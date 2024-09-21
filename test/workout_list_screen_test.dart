// test/workout_list_screen_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:testproject/Components/models/workout.dart';
import 'package:testproject/Components/models/workout_sets.dart';
import 'package:testproject/Components/providers/workout_provider.dart';
import 'package:testproject/Screens/workout_list_screen.dart';


void main() {
  testWidgets('Workout List Screen shows workout items and handles delete action', (WidgetTester tester) async {
    final workoutProvider = WorkoutProvider();
    workoutProvider.addWorkout(Workout(
      id: '1',
      sets: [
        WorkoutSet(exercise: 'Bench press', weight: 50, repetitions: 10),
      ],
    ));

    await tester.pumpWidget(
      ChangeNotifierProvider<WorkoutProvider>.value(
        value: workoutProvider,
        child: MaterialApp(home: WorkoutListScreen()),
      ),
    );

    // Verify the workout is shown
    expect(find.text('Workout 1'), findsOneWidget);

    // Simulate delete action
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pump(); // Rebuild the widget after the state change

    // Verify the workout is removed
    expect(find.text('Workout 1'), findsNothing);
  });
}

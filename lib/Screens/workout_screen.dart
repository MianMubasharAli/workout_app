// lib/workout_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testproject/Components/models/workout.dart';
import 'package:testproject/Components/models/workout_sets.dart';
import 'package:testproject/Components/providers/workout_provider.dart';


class WorkoutScreen extends StatefulWidget {
  final String? workoutId;

  WorkoutScreen({this.workoutId});

  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  List<WorkoutSet> _sets = [];
  final List<String> _exercises = ['Barbell row', 'Bench press', 'Shoulder press', 'Deadlift', 'Squat'];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.workoutId != null) {
      final workoutProvider = Provider.of<WorkoutProvider>(context, listen: false);
      final existingWorkout = workoutProvider.workouts.firstWhere((workout) => workout.id == widget.workoutId);
      _sets = List.from(existingWorkout.sets);
    }
  }

  void _saveWorkout() {
    if (_sets.isEmpty) {
      _deleteWorkout(); // Automatically delete workout if no sets are left
    } else {
      final workoutProvider = Provider.of<WorkoutProvider>(context, listen: false);
      final workout = Workout(id: widget.workoutId ?? DateTime.now().toString(), sets: _sets);

      if (widget.workoutId == null) {
        workoutProvider.addWorkout(workout);
      } else {
        workoutProvider.updateWorkout(widget.workoutId!, workout);
      }

      Navigator.of(context).pop();
    }
  }

  void _addSet() {
    setState(() {
      _sets.add(WorkoutSet(exercise: _exercises[0], weight: 0, repetitions: 0));
    });
  }

  void _removeSet(int index) {
    setState(() {
      _sets.removeAt(index);
      if (_sets.isEmpty) {
        _deleteWorkout(); // Auto-delete workout if last set is removed
      }
    });
  }

  void _deleteWorkout() {
    final workoutProvider = Provider.of<WorkoutProvider>(context, listen: false);
    if (widget.workoutId != null) {
      workoutProvider.deleteWorkout(widget.workoutId!);
    }
    Navigator.of(context).pop(); // Return to the previous screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveWorkout,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _sets.length,
        itemBuilder: (context, index) {
          final set = _sets[index];
          return ListTile(
            title: DropdownButton<String>(
              value: set.exercise,
              onChanged: (value) {
                setState(() {
                  set.exercise = value!;
                });
              },
              items: _exercises.map((exercise) {
                return DropdownMenuItem(
                  child: Text(exercise),
                  value: exercise,
                );
              }).toList(),
            ),
            subtitle: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Weight (kg)'),
                    keyboardType: TextInputType.number,
                    initialValue: set.weight.toString(),
                    onChanged: (value) {
                      set.weight = double.parse(value);
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Reps'),
                    keyboardType: TextInputType.number,
                    initialValue: set.repetitions.toString(),
                    onChanged: (value) {
                      set.repetitions = int.parse(value);
                    },
                  ),
                ),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _removeSet(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addSet,
        child: Icon(Icons.add),
      ),
    );
  }
}







// // lib/workout_screen.dart
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:testproject/Components/models/workout.dart';
// import 'package:testproject/Components/models/workout_sets.dart';
// import 'package:testproject/Components/providers/workout_provider.dart';
//
//
// class WorkoutScreen extends StatefulWidget {
//   final String? workoutId;
//
//   WorkoutScreen({this.workoutId});
//
//   @override
//   _WorkoutScreenState createState() => _WorkoutScreenState();
// }
//
// class _WorkoutScreenState extends State<WorkoutScreen> {
//   List<WorkoutSet> _sets = [];
//   final List<String> _exercises = ['Barbell row', 'Bench press', 'Shoulder press', 'Deadlift', 'Squat'];
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     if (widget.workoutId != null) {
//       final workoutProvider = Provider.of<WorkoutProvider>(context, listen: false);
//       final existingWorkout = workoutProvider.workouts.firstWhere((workout) => workout.id == widget.workoutId);
//       _sets = List.from(existingWorkout.sets);
//     }
//   }
//
//   void _saveWorkout() {
//     final workoutProvider = Provider.of<WorkoutProvider>(context, listen: false);
//     final workout = Workout(id: widget.workoutId ?? DateTime.now().toString(), sets: _sets);
//
//     if (widget.workoutId == null) {
//       workoutProvider.addWorkout(workout);
//     } else {
//       workoutProvider.updateWorkout(widget.workoutId!, workout);
//     }
//
//     Navigator.of(context).pop();
//   }
//
//   void _addSet() {
//     setState(() {
//       _sets.add(WorkoutSet(exercise: _exercises[0], weight: 1, repetitions: 1));
//     });
//   }
//
//   void _removeSet(int index) {
//     setState(() {
//       _sets.removeAt(index);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Workout'),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.save),
//             onPressed: _saveWorkout,
//           ),
//         ],
//       ),
//       body: ListView.builder(
//         itemCount: _sets.length,
//         itemBuilder: (context, index) {
//           final set = _sets[index];
//           return ListTile(
//             title: DropdownButton<String>(
//               value: set.exercise,
//               onChanged: (value) {
//                 setState(() {
//                   set.exercise = value!;
//                 });
//               },
//               items: _exercises.map((exercise) {
//                 return DropdownMenuItem(
//                   child: Text(exercise),
//                   value: exercise,
//                 );
//               }).toList(),
//             ),
//             subtitle: Row(
//               children: [
//                 Expanded(
//                   child: TextFormField(
//                     decoration: InputDecoration(labelText: 'Weight (kg)'),
//                     keyboardType: TextInputType.number,
//                     initialValue: set.weight.toString(),
//                     onChanged: (value) {
//                       set.weight = double.parse(value);
//                     },
//                   ),
//                 ),
//                 SizedBox(width: 10),
//                 Expanded(
//                   child: TextFormField(
//                     decoration: InputDecoration(labelText: 'Reps'),
//                     keyboardType: TextInputType.number,
//                     initialValue: set.repetitions.toString(),
//                     onChanged: (value) {
//                       set.repetitions = int.parse(value);
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             trailing: IconButton(
//               icon: Icon(Icons.delete),
//               onPressed: () => _removeSet(index),
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _addSet,
//         child: Text("Add",style: TextStyle(
//           fontWeight: FontWeight.bold
//         ),),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:testproject/Components/providers/workout_provider.dart';

import 'workout_screen.dart';

class WorkoutListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle:true,
        title: Text('Recorded Workouts'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<WorkoutProvider>(
              builder: (context, provider, child) {
                return provider.workouts.length == 0 ? Container(
                    alignment: Alignment.center,
                    child: Text("No workout recorded")) :ListView.builder(
                  itemCount: provider.workouts.length,
                  itemBuilder: (context, index) {
                    final workout = provider.workouts[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 5,left: 10,right: 10),
                      padding: EdgeInsets.all(0),
                      constraints: BoxConstraints(),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.all(Radius.circular(5))

                      ),
                      child: ListTile(
                        title: Text('Workout ${index + 1}',style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => WorkoutScreen(workoutId: workout.id),
                            ),
                          );
                        },
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            provider.deleteWorkout(workout.id);
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          InkWell(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => WorkoutScreen(),
              ),
            ),
            child: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border()
              ),
              child: Text("Record Workout",style: TextStyle(
                fontWeight: FontWeight.bold
              ),),
            ),
          )

        ],
      ),
    );
  }
}

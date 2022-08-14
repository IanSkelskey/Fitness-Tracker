import 'package:flutter/material.dart';
import 'mysql_helper.dart';

class ExerciseListView extends StatefulWidget {
  const ExerciseListView({Key? key}) : super(key: key);

  @override
  State<ExerciseListView> createState() => _ExerciseListViewState();
}

class _ExerciseListViewState extends State<ExerciseListView> {
  bool isInitialized = false;

  List<String> exercises = [];
  List<String> muscles = [];

  Future<void> initializeLists() async {
    if (isInitialized == true) {
      return;
    }
    var results = await MySQLHelper.conn
        .query('SELECT name, primarymuscle FROM exercise');
    for (var row in results) {
      setState(() {
        exercises.add(row[0].toString());
        muscles.add(row[1].toString());
      });
    }
    setState(() {
      isInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeLists();
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: exercises.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(exercises.elementAt(index)),
              subtitle: Text(muscles.elementAt(index)),
            );
          },
        ),
      ),
    );
  }
}

import 'package:fitness_tracker/mysql_helper.dart';
import 'package:flutter/material.dart';
import 'bottom_nav.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    MySQLHelper.initConnection('root', 'SmartMuscle', 'fitness_db');
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Exercises'),
        ),
        body: const BottomNav(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Do Nothing
          },
          backgroundColor: Colors.blue,
          child: const Text('Query'),
        ),
      ),
    );
  }
}

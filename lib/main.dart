import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Exercises'),
        ),
        body: const Center(
          child: ListViewWithButton(),
        ),
      ),
    );
  }
}

class ListViewWithButton extends StatefulWidget {
  const ListViewWithButton({Key? key}) : super(key: key);

  @override
  State<ListViewWithButton> createState() => _ListViewWithButtonState();
}

class _ListViewWithButtonState extends State<ListViewWithButton> {
  var db = MySQL();
  List<String> exercises = [];
  List<String> muscles = [];

  Future<void> _populateSongs() async {
    MySqlConnection conn = await db.getConnection();
    var results = await conn.query('SELECT name, primarymuscle FROM exercise');
    for (var row in results) {
      setState(() {
        exercises.add(row[0].toString());
        muscles.add(row[1].toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            label: 'Exercises',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.comment),
            label: 'Social',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _populateSongs();
        },
        backgroundColor: Colors.blue,
        child: const Text('Query'),
      ),
    );
  }
}

class MySQL {
  Future<MySqlConnection> getConnection() async {
    var settings = ConnectionSettings(
      user: 'root',
      password: 'SmartMuscle',
      db: 'fitness_db',
    );
    var conn = await MySqlConnection.connect(settings);
    // Waiting 1 second for connection to establish. Unexpected
    // behavior without this line. See comment:
    // https://github.com/adamlofts/mysql1_dart/issues/88#issuecomment-894639665
    await Future.delayed(const Duration(seconds: 1));
    return conn;
  }
}

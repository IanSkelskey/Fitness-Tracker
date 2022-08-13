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
          title: const Text('Navigation Bar Example'),
        ),
        body: const Center(
          child: NavBarSample(),
        ),
      ),
    );
  }
}

class NavBarSample extends StatefulWidget {
  const NavBarSample({Key? key}) : super(key: key);

  @override
  State<NavBarSample> createState() => _NavBarSampleState();
}

class _NavBarSampleState extends State<NavBarSample> {
  var db = MySQL();
  var albums = 'Awaiting query results...';

  Future<void> _getAlbum() async {
    MySqlConnection conn = await db.getConnection();
    print('Im getting albums');
    var results = await conn.query('SELECT * FROM artist');
    results = await conn.query('SELECT * FROM album');
    for (var row in results) {
      print('Row Data: $row');
      setState(() {
        albums = row[1].toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          albums,
          style: const TextStyle(fontSize: 30),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _getAlbum();
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
      password: 'Harmony-11',
      db: 'record-store',
    );
    var conn = await MySqlConnection.connect(settings);
    // Waiting 1 second for connection to establish. Unexpected
    // behavior without this line. See comment:
    // https://github.com/adamlofts/mysql1_dart/issues/88#issuecomment-894639665
    await Future.delayed(const Duration(seconds: 1));
    return conn;
  }
}

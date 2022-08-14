import 'package:mysql1/mysql1.dart';

class MySQLHelper {

  static late MySqlConnection conn;

  static Future<MySqlConnection> initConnection(String user, String password, String db) async {
    var settings = ConnectionSettings(
      user: user,
      password: password,
      db: db,
    );
    conn = await MySqlConnection.connect(settings);
    // Waiting 1 second for connection to establish. Unexpected
    // behavior without this line. See comment:
    // https://github.com/adamlofts/mysql1_dart/issues/88#issuecomment-894639665
    await Future.delayed(const Duration(milliseconds: 500));
    return conn;
  }

}

import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  final String path;
  late Database database;

  DatabaseManager({required this.path});

  Future open() async {
    database = await openDatabase(path);
  }

  Future close() async {
    await database.close();
  }

  Future<int> getVersion() async {
    return database.getVersion();
  }

  Future setVersion(int version) async {
    await database.setVersion(version);
  }

  Future exec(String sql) async {
    await database.execute(sql);
  }

  Future<List<Map<String, dynamic>>> list(String query, [final List<String> args = const <String>[]]) async {
    final queryResult = await database.rawQuery(query, args);
    return queryResult.toList();
  }
}

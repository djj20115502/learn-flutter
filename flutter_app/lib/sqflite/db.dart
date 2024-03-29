import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class Db {
  Database database;
  getDb() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
    if (database == null) {
      database = await openDatabase('my_db.db');
    }
    getApplicationDocumentsDirectory();
    return database;
  }

  initDb() async {
    var databasesPath = await getDatabasesPath();
    String path = databasesPath + '/demo.db';
    await deleteDatabase(path);

    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)');
    });

// Insert some records in a transaction
    await database.transaction((txn) async {
      int id1 = await txn.rawInsert(
          'INSERT INTO Test(name, value, num) VALUES("some name", 1234, 456.789)');
      print('inserted1: $id1');
      int id2 = await txn.rawInsert(
          'INSERT INTO Test(name, value, num) VALUES(?, ?, ?)',
          ['another name', 12345678, 3.1416]);
      print('inserted2: $id2');
    });

// Update some record
    int count = await database.rawUpdate(
        'UPDATE Test SET name = ?, VALUE = ? WHERE name = ?',
        ['updated name', '9876', 'some name']);
    print('updated: $count');

// Get the records
    List<Map> list = await database.rawQuery('SELECT * FROM Test');
    List<Map> expectedList = [
      {'name': 'updated name', 'id': 1, 'value': 9876, 'num': 456.789},
      {'name': 'another name', 'id': 2, 'value': 12345678, 'num': 3.1416}
    ];
    print(list);
    print(expectedList);

// Count the records
    count = Sqflite.firstIntValue(
        await database.rawQuery('SELECT COUNT(*) FROM Test'));
    assert(count == 2);

// Delete a record
    count = await database
        .rawDelete('DELETE FROM Test WHERE name = ?', ['another name']);
    assert(count == 1);

// Close the database
    await database.close();
  }

  close() => database?.close();
}

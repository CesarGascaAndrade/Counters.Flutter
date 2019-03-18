import 'package:counters/Models/Counter.dart';
import 'package:counters/Repositories/iCounterRepository.dart';
import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';

class CountersRepository implements iCountersRepository {
  var databasesPath;
  Database database;

  CountersRepository() {
    databasesPath = getDatabasesPath();
    String path = join(databasesPath, 'counters.db');
    database = openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE IF NOT EXISTS counters (id INTEGER PRIMARY KEY, name TEXT, count INTEGER)');
    }) as Database;
  }

  void Save(Counter counter) {
    int count = 0;

    if(counter.count != null) {
      count = counter.count;
    }

    if (counter.id != null) {
      //update
      this.database.rawUpdate(
          'UPDATE counters SET name = ?, count = ? WHERE id = ?',
          [counter.name, count, counter.id]);
    } else {
      //insert
      this.database.rawInsert(
          'INSERT INTO counters(name, count) VALUES(?, ?)', [counter.name, count]);
    }
  }

  void Delete(Counter counter) {
    this.database.rawDelete('DELETE FROM counters WHERE id = ?',[counter.id]);
  }

  List<Counter> GetAll() {
    List<Counter> counters;
    this.database.rawQuery('SELECT * FROM Test').then((List<Map<String, dynamic>> result) {
      result.forEach((Map<String, dynamic> row) {
        counters.add(new Counter(
          id: row['id'],
          name: row['name'],
          count: row['count']
        ));
      });
    });

    return counters;
  }
}

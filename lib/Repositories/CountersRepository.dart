import 'dart:async';

import 'package:counters/Models/Counter.dart';
import 'package:counters/Repositories/Repository.dart';
import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';

class CountersRepository extends Repository {
  final String tableName = "counters";

  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    // Get a location using path_provider
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, databaseName);

    //await deleteDatabase(path);
    var theDb = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE IF NOT EXISTS $tableName (id INTEGER PRIMARY KEY AUTOINCREMENT, name STRING, count INT);');
    });

    return theDb;
  }

  Future<List<Counter>> GetAll() async {
    var dbClient = await db;

    List<Map<String, dynamic>> list =
        await dbClient.rawQuery('SELECT * FROM $tableName');

    List<Counter> items = new List();

    list.forEach((item) {
      items.add(
          Counter(id: item['id'], name: item['name'], count: item['count']));
    });

    return items;
  }

  Future save(Counter counter) async {
    var dbClient = await db;
    String q;
    if (counter.id == 0) {
      q = "insert into $tableName(name, count) values('${counter.name}',0)";
    } else {
      q = "update $tableName set name = '${counter.name}', count = ${counter.count} where id = ${counter.id}";
    }
    dbClient.rawQuery(q);
  }

  Future delete(Counter counter) async {
    var dbClient = await db;
    await dbClient.rawQuery("delete from $tableName where id = ${counter.id}");
  }
}

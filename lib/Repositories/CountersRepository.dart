import 'dart:async';
import 'dart:convert';

import 'package:counters/Models/Counter.dart';
import 'package:counters/Repositories/iCounterRepository.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';

class CountersRepository  {
  final String tableName = "Gear";

  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    //await importData();
    return _db;
  }

  initDb() async {
    // Get a location using path_provider
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "gear_log.db");

    //await deleteDatabase(path);
    var theDb = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      print('creating db...');

      await db.execute('CREATE TABLE IF NOT EXISTS counters (id INTEGER PRIMARY KEY AUTOINCREMENT, name STRING, count INT);');
      
    });

    return theDb;
  }

  importData() async {
    final datasources =
        'observation_bodyissue.json,observation_observation.json,observation_observation_bodyIssues.json,observation_observation_shoeIssues.json,observation_shoeissue.json,observation_gearissue.json,runner_runner.json,gear_actualpair.json,gear_characteristic.json,gear_shoe.json,gear_family.json,gear_maker.json,gear_gear.json,gear_gear_characteristics.json,users_user.json'
            .split(',');
    var batch = _db.batch();

    for (var datasource in datasources) {
      try {
        String str = await rootBundle.loadString('assets/db/data/$datasource');
        String table = datasource.split('.')[0];

        if (str.length > 0 && str != '[]') {
          List<dynamic> _list = await json.decode(str);
          for (var _json in _list) {
            batch.insert(table, _json);
          }
        }
      } catch (e) {
        print(e.toString());
      }
    }
    print('added db data');
    var results = await batch.commit();
    
  }

  Future<List<Counter>> GetAll() async {
    var dbClient = await db;
    
    //testing purporses
    //await dbClient.rawQuery("insert into counters(name, count) values('test',0)");

    List<Map<String,dynamic>> list = await dbClient.rawQuery('SELECT * FROM counters');

    List<Counter> items = new List();
    
    list.forEach((item) {
      items.add(Counter(
        id: item['id'],
        name: item['name'],
        count: item['count']
      ));
    });

    return items;
  }

  Future save(Counter counter) async {
    var dbClient = await db;
    await dbClient.rawQuery("update counters set count = ${counter.count} where id = ${counter.id}");
  }

  Future delete(Counter counter) async {
    var dbClient = await db;
    await dbClient.rawQuery("delete from counters where id = ${counter.id}");
  }
}

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:workflow_management_app/features/tasks/screens/personal_tasks/models/personal_task.dart';


class DBHelper {
  static Database? _db;
  static final int _versoin = 1;
  static final String _tableName ="tasks";

  static Future<void> initDb()async {
    if(_db != null){
      return;
    }
    try {
      String _path = await getDatabasesPath() + 'tasks.db';
      _db = await openDatabase(
        _path,
        version: _versoin,
        onCreate: (db, versoin) {
          print("creating a new one");
          return db.execute(
            "CREATE TABLE $_tableName("
                "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                "title STRING, note TEXT, date STRING, "
                "startTime STRING, endTime STRING, "
                "remind INTEGER, repeat STRING, "
                "color INTEGER, "
                "isCompleted INTEGER)",
          );
        }
      );
    } catch (e) {
      print(e);
    }
  }
  static Future<int> insert(PersonalTask? task) async {
    print("insert function called");
    return await _db?.insert(_tableName, task!.toJson())??1;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    print("query function called");
    return await _db!.query(_tableName);
  }

  static delete(PersonalTask task)async {
   return await _db!.delete(_tableName, where: 'id=?', whereArgs: [task.id]);
  }

  static update(int? id) async {
    if(id !=null){
      return await _db!.rawUpdate('''
    UPDATE tasks
    SET isCompleted = ?
    WHERE id =?
    ''',[1,id]);
    }

  }
}
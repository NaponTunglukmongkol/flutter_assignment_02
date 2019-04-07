
import 'package:sqflite/sqflite.dart';

final String tableTodo = "todo";
final String columnId = "_id";
final String columnTitle = "title";
final String columnDone = "done";

class Todo {
  int id;
  String title;
  bool done;

  Todo();

  Todo.formMap(Map<String, dynamic> map) {
    this.id = map[columnId];
    this.title = map[columnTitle];
    this.done = map[columnDone] == 1;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      columnTitle: title,
      columnDone: done == true ? 1 : 0
    };

    if (id != null) {
      map[columnId] = id;
    }

    return map;
  }
}

class TodoProvider {
  Database db;

  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
      create table $tableTodo (
        $columnId integer primary key autoincrement,
        $columnTitle text not null,
        $columnDone interger not null
      )
      ''');
    });
  }

  Future<Todo> insert(Todo todo) async {
    db.insert(tableTodo, todo.toMap());
    return todo;
  }

  Future<Todo> getTodo() async {
    List<Map> map = await db.query(tableTodo,
        columns: [columnId, columnDone, columnTitle],
        where: "$columnDone = 0");

    if (map.length > 0) {
      return new Todo.formMap(map.first);
    } else {
      return null;
    }
  }

  Future<List> getTask() async{
    List<Map<String, dynamic>> data = await db.query(
      tableTodo,
      //where: '$columnDone = 0'
    );
    return data.map((f) => Todo.formMap(f)).toList();
  }

  Future<int> delete(int id) async {
    return db.delete(tableTodo, where: '$columnId = ?', whereArgs: [id]);
  }

  Future deleteAll() async {
    print("deleted");
    return db.delete(tableTodo);
  }

  Future<int> update(Todo todo) async {
    return db.update(tableTodo, todo.toMap(),
        where: '$columnId = ?', whereArgs: [todo.id]);
  }

  Future close() => db.close();
}

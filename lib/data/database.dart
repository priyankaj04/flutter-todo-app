import 'package:hive_flutter/hive_flutter.dart';

class TodoDatabase {
  List todoList = [];

  // reference our box
  final _mybox = Hive.box('mybox');

// run this method if this it the first time ever opening this app
  void createInitialData() {
    todoList = [
      ["Exercise", false, "12/10/2023 19: 30"],
      ["Learn Flutter", false, "12/10/2023 19: 30"],
    ];
  }

  // load the data for database
  void loadData() {
    todoList = _mybox.get("TODOLIST");
  }

  // update the database
  void updateData() {
    _mybox.put("TODOLIST", todoList);
  }
}

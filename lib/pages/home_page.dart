// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutterlearning/data/database.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../util/dailoge_box.dart';
import '../util/todo_list.dart';
import 'dart:core';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference the hive box
  final _myBox = Hive.box('mybox');
  TodoDatabase db = TodoDatabase();

  DateTime currentDate = DateTime.now();

  @override
  void initState() {
    // if this is the first time ever opening the app - create default data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      // there already exists data
      db.loadData();
    }
    print(db.todoList);
    super.initState();
  }

  //Text controller
  final _controller = TextEditingController();

  void checkboxChange(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = value;
    });
    if (value != null && value) {
      showMessage(context, "Task is completed successfully!");
    }
    db.updateData();
  }

  // save new task
  void saveNewTask() {
    setState(() {
      db.todoList.add([
        _controller.text,
        false,
        DateFormat("dd MMM yyyy HH:mm").format(currentDate)
      ]);
      _controller.clear();
    });
    showMessage(context, "Task created successfully!");
    Navigator.of(context).pop();
    db.updateData();
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return Dailogbox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () {
              Navigator.of(context).pop();
              _controller.clear();
            },
          );
        });
    db.updateData();
  }

  //delete task
  void deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
    showMessage(context, "Task is deleted successfully!");
    db.updateData();
  }

  void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.deepOrange,
        showCloseIcon: true,
        closeIconColor: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepOrange[200],
        appBar: AppBar(
          title: const Text("Todo"),
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: createNewTask, child: Icon(Icons.add)),
        body: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Text(
              "Let's Finish it!",
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: db.todoList.length,
                itemBuilder: (context, index) {
                  return TodoList(
                    taskname: db.todoList[index][0],
                    taskstatus: db.todoList[index][1],
                    onChanged: (value) => checkboxChange(value, index),
                    deleteTask: (context) => deleteTask(index),
                    datetime: db.todoList[index][2],
                  );
                },
              ),
            ),
          ],
        ));
  }
}

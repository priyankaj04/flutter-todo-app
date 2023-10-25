// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoList extends StatelessWidget {
  final String taskname;
  final bool taskstatus;
  final String datetime;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteTask;

  TodoList(
      {super.key,
      required this.taskname,
      required this.taskstatus,
      required this.onChanged,
      required this.deleteTask,
      required this.datetime});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
                onPressed: deleteTask,
                icon: Icons.delete,
                backgroundColor: Colors.red.shade500,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10)))
          ],
        ),
        child: Container(
          padding: EdgeInsets.only(left: 18, top: 18, bottom: 18, right: 8),
          decoration: BoxDecoration(
            color: Colors.deepOrange[500],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // checkbox
              Checkbox(
                value: taskstatus,
                onChanged: onChanged,
                activeColor: Colors.deepOrange[900],
              ),

              //tast name
              Expanded(
                child: Text(
                  taskname,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                    decoration: taskstatus
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ),

              Text(datetime,
                  style: TextStyle(
                    color: Color.fromARGB(255, 221, 221, 221),
                    fontSize: 12.0,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

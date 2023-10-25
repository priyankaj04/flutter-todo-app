// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutterlearning/util/mybutton.dart';

class Dailogbox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  Dailogbox(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.deepOrange[200],
      content: Container(
          height: 150,
          child: Column(
            children: [
              Text("Add New Task",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  )),
              const SizedBox(height: 10),
              TextField(
                controller: controller,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "New Task",
                  prefixIcon: Icon(Icons.task),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Mybutton(
                    text: "Save",
                    onPressed: onSave,
                  ),
                  const SizedBox(width: 15),
                  Mybutton(
                    text: "Cancel",
                    onPressed: onCancel,
                  )
                ],
              )
              // new button for save and cancel
            ],
          )),
    );
  }
}

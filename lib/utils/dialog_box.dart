import 'package:flutter/material.dart';
import 'package:to_do_list/utils/my_button.dart';

class DialogBox extends StatelessWidget {
  // constructors
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  }); //require a controller when creating textfield

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Colors.yellow,
        content: Container(
          height: 200,
          child: Column(
            children: [
              // get user input
              TextField(
                controller: controller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "Add a new task"),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // save button
                  MyButton(text: "Save", onPressed: onSave),

                  const SizedBox(width: 8),

                  // cancel button
                  MyButton(text: "Cancel", onPressed: onCancel),
                ],
              )
            ],
          ),
        ));
  }
}

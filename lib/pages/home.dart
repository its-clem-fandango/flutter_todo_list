import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do_list/data/database.dart';
import 'package:to_do_list/utils/dialog_box.dart';
import "package:to_do_list/utils/todo_tile.dart";

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //reference the hive box
  final _myBox = Hive.box("mybox");
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    //if this is first time ever opening app, then create default data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      // if its not the first time user has opened the app load the data
      db.loadData();
    }
    super.initState();
  }

  // Dialog box text controller so we can access the user input text
  final dialogController = TextEditingController();

//checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    // switch state using logical not operator. If List at [index][1] is false
    // change the List at [index][1] to true ! and vice-versa
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDatabase();
  }

  // save new task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([dialogController.text, false]);

      //clear the dialog box after saving
      dialogController.clear();
    });
    // popping dismisses the pop-up
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  // create a new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: dialogController,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop,
        );
      },
    );
  }

  // delete task, we want to know which task we're talking about so we require the index
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("TO DO"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          child: const Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: db.toDoList.length,
          //NOTES: the index in the item builder refers to the item which we're talking about
          itemBuilder: (context, index) {
            return ToDoTile(
              taskName: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
              deleteFunction: (context) => deleteTask(index),
            );
          },
        ));
  }
}

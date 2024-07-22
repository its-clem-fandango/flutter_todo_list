import 'package:hive/hive.dart';

class ToDoDataBase {
  List toDoList = [];
  // reference the box --> box is opened in main.dart
  final _myBox = Hive.box("mybox");

// run this method if first time ever opening app
  void createInitialData() {
    toDoList = [
      ["Make Breakfast", false],
      ["Workout", false],
    ];
  }

  //load the data from the database
  void loadData() {
    toDoList =
        _myBox.get("TODOLIST"); //this is the key for our key-value storage
  }

  //update the database
  void updateDatabase() {
    _myBox.put("TODOLIST", toDoList);
  }
}

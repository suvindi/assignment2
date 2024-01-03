import 'package:flutter/material.dart';
import 'dart:math';

class Task {
  String name;
  String description;
  String tag;

  Task({required this.name, required this.description, required this.tag});
}

class ToDoList extends StatefulWidget {
  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  List<Task> tasks = [];
  String? selectedTag;

  // Map to associate names with tags
  Map<String, String> tagNames = {
    'Tag1': 'Work',
    'Tag2': 'Personal',
    'Tag3': 'Study',
    'Tag4': 'Shopping',
  };

  // List of predefined colors for CircleAvatar
  List<Color> circleAvatarColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.red,
    Colors.teal,
  ];

  void addTask(String name, String description, String tag) {
    setState(() {
      tasks.add(Task(name: name, description: description, tag: tag));
      selectedTag = null;
    });
  }

  void editTask(int index, String name, String description, String tag) {
    setState(() {
      tasks[index] = Task(name: name, description: description, tag: tag);
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  Future<void> _showAddTaskDialog(BuildContext context) async {
    String name = '';
    String description = '';

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Task'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(Icons.task_alt_outlined, color: Colors.grey),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 16.0),
                      child: TextField(
                        onChanged: (value) {
                          name = value;
                        },
                        decoration: InputDecoration(
                          hintText: 'Task Name',
                          border: OutlineInputBorder(), // Add border here
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.description_outlined, color: Colors.grey),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 16.0),
                      child: TextField(
                        onChanged: (value) {
                          description = value;
                        },
                        decoration: InputDecoration(
                          hintText: 'Description',
                          border: OutlineInputBorder(), // Add border here
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.tag, color: Colors.grey),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selectedTag,
                      onChanged: (value) {
                        setState(() {
                          selectedTag = value!;
                        });
                      },
                      items: tagNames.keys.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(tagNames[value]!),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        hintText: 'Tag',
                        border: OutlineInputBorder(), // Add border here
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                addTask(name, description, selectedTag!);
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showEditTaskDialog(BuildContext context, int index) async {
    String name = tasks[index].name;
    String description = tasks[index].description;
    String tag = tasks[index].tag;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Task'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(Icons.task_alt_outlined, color: Colors.grey),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 16.0),
                      child: TextField(
                        controller: TextEditingController(text: name),
                        onChanged: (value) {
                          name = value;
                        },
                        decoration: InputDecoration(
                          hintText: 'Task Name',
                          border: OutlineInputBorder(), // Add border here
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.description_outlined, color: Colors.grey),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 16.0),
                      child: TextField(
                        controller: TextEditingController(text: description),
                        onChanged: (value) {
                          description = value;
                        },
                        decoration: InputDecoration(
                          hintText: 'Description',
                          border: OutlineInputBorder(), // Add border here
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.tag, color: Colors.grey),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: tag,
                      onChanged: (value) {
                        setState(() {
                          tag = value!;
                        });
                      },
                      items: tagNames.keys.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(tagNames[value]!),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        hintText: 'Tag',
                        border: OutlineInputBorder(), // Add border here
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                editTask(index, name, description, tag);
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDeleteTaskDialog(BuildContext context, int index) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text('Delete Task')),
          content: Text('Are you sure you want to delete this task?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                deleteTask(index);
                Navigator.pop(context);
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  Color getRandomColor() {
    // Use Random class to get a random color from the predefined list
    Random random = new Random();
    return circleAvatarColors[random.nextInt(circleAvatarColors.length)];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('To-Do List')),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(tasks[index].hashCode.toString()),
                    background: Container(
                      color: Colors.red,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onDismissed: (direction) {
                      _showDeleteTaskDialog(context, index);
                    },
                    child: Card(
                      elevation: 2.0,
                      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 8.0,
                          backgroundColor: getRandomColor(),
                        ),
                        title: Text(tasks[index].name),
                        subtitle: Text(tasks[index].description),
                        trailing: PopupMenuButton<String>(
                          onSelected: (value) {
                            if (value == 'edit') {
                              _showEditTaskDialog(context, index);
                            } else if (value == 'delete') {
                              _showDeleteTaskDialog(context, index);
                            }
                          },
                          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                            PopupMenuItem<String>(
                              value: 'edit',
                              child: ListTile(
                                leading: Icon(Icons.edit),
                                title: Text('Edit'),
                              ),
                            ),
                            PopupMenuItem<String>(
                              value: 'delete',
                              child: ListTile(
                                leading: Icon(Icons.delete),
                                title: Text('Delete'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 40),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: FloatingActionButton(
              onPressed: () {
                _showAddTaskDialog(context);
              },
              child: Icon(Icons.add),
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(ToDoList());
}

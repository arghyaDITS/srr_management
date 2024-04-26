import 'package:flutter/material.dart';
import 'package:srr_management/Screens/task/taskModel.dart';

class ArchivedTaskList extends StatefulWidget {
  const ArchivedTaskList({super.key});

  @override
  State<ArchivedTaskList> createState() => _ArchivedTaskListState();
}

class _ArchivedTaskListState extends State<ArchivedTaskList> {
  final List<Task> archivedTasks = [
    Task(
        name: 'Task 1',
        description: 'Description of Task 1',
        imagePath: 'assets/task1_image.jpg',
        
        isDone: false),
    Task(
        name: 'Task 2',
        description: 'Description of Task 2',
        imagePath: 'assets/task2_image.jpg',
        isDone: true),
    Task(
        name: 'Task 3',
        description: 'Description of Task 3',
        imagePath: 'assets/task3_image.jpg',
        isDone: false),
    Task(
        name: 'Task 4',
        description: 'Description of Task 4',
        imagePath: 'assets/task3_image.jpg',
        isDone: false),
    Task(
        name: 'Task 5',
        description: 'Description of Task 5',
        imagePath: 'assets/task3_image.jpg',
        isDone: false),
    Task(
        name: 'Task 6',
        description: 'Description of Task 6',
        imagePath: 'assets/task3_image.jpg',
        isDone: true),
    Task(
        name: 'Task 7',
        description: 'Description of Task 7',
        imagePath: 'assets/task3_image.jpg',
        isDone: true),
    Task(
        name: 'Task 8',
        description: 'Description of Task 8',
        imagePath: 'assets/task3_image.jpg',
        isDone: true),
    Task(
        name: 'Task 9',
        description: 'Description of Task 9',
        imagePath: 'assets/task3_image.jpg',
        isDone: false),
    Task(
        name: 'Task 10',
        description: 'Description of Task 10',
        imagePath: 'assets/task3_image.jpg',
        isDone: false),
  ];
  void _showUnarchiveDialog(BuildContext context,  task) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Unarchive Task'),
          content: Text('Are you sure you want to unarchive this task?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                _unarchiveTask(task);
                Navigator.of(context).pop();
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  taskElement({task, onPress, color}) {
    return Card(
      color:  Color.fromARGB(255, 175, 212, 247) ,
      elevation: 2,
      child: ListTile(
        leading: Image.asset(
          'images/logo.jpg',
          width: 50,
          height: 50,
        ),
        title: Text(task.name),
        subtitle: Text(task.description),
        trailing: IconButton(
          icon: Icon(Icons.unarchive),
          onPressed: onPress,
        ),
        onTap: onPress,
      ),
    );
  }

  void _unarchiveTask(task) {
    setState(() {
      archivedTasks.remove(task);
      // Add the unarchived task to a new list or perform any other actions as needed
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Archived Tasks'),
      ),
      body: ListView.builder(
        itemCount: archivedTasks.length,
        itemBuilder: (context, index) {
          return taskElement(
              task: archivedTasks[index],
              onPress: () {
                _showUnarchiveDialog(context, archivedTasks[index]);
              });

          // ListTile(
          //   title: Text(archivedTasks[index]),
          //   trailing: IconButton(
          //     icon: Icon(Icons.unarchive),
          //     onPressed: () {
          //       _showUnarchiveDialog(context, archivedTasks[index]);
          //     },
          //   ),

          // );
        },
      ),
    );
  }
}

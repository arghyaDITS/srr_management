import 'package:flutter/material.dart';
import 'package:srr_management/Screens/task/taskDetailScreen.dart';
import 'package:srr_management/Screens/task/taskModel.dart';
import 'package:srr_management/components/buttons.dart';
import 'package:srr_management/theme/style.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final List<Task> tasks = [
    Task(
        name: 'Task 1',
        description: 'Description of Task 1',
        imagePath: 'assets/task1_image.jpg',
        isDone: true),
    Task(
        name: 'Task 2',
        description: 'Description of Task 2',
        imagePath: 'assets/task2_image.jpg',
        isDone: false),
    Task(
        name: 'Task 3',
        description: 'Description of Task 3',
        imagePath: 'assets/task3_image.jpg',
        isDone: true),
    Task(
        name: 'Task 3',
        description: 'Description of Task 3',
        imagePath: 'assets/task3_image.jpg',
        isDone: false),
    Task(
        name: 'Task 3',
        description: 'Description of Task 3',
        imagePath: 'assets/task3_image.jpg',
        isDone: false),
    Task(
        name: 'Task 3',
        description: 'Description of Task 3',
        imagePath: 'assets/task3_image.jpg',
        isDone: true),
    Task(
        name: 'Task 3',
        description: 'Description of Task 3',
        imagePath: 'assets/task3_image.jpg',
        isDone: true),
    Task(
        name: 'Task 3',
        description: 'Description of Task 3',
        imagePath: 'assets/task3_image.jpg',
        isDone: false),
    Task(
        name: 'Task 3',
        description: 'Description of Task 3',
        imagePath: 'assets/task3_image.jpg',
        isDone: false),
    Task(
        name: 'Task 3',
        description: 'Description of Task 3',
        imagePath: 'assets/task3_image.jpg',
        isDone: true),
  ];
  taskElement({task, onPress, iconPress}) {
    return Card(
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
          icon: Icon(Icons.archive),
          onPressed: iconPress,
        ),
        onTap: onPress,
      ),
    );
  }

  void _showarchiveDialog(BuildContext context, task) {
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
                _archiveTask(task);
                Navigator.of(context).pop();
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _archiveTask(task) {
    setState(() {
      tasks.remove(task);
      // Add the unarchived task to a new list or perform any other actions as needed
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Tasks'),
        actions: [
          // ArrowButton(
          //   onClick: () {
          //     // Navigator.push(context,
          //     //     MaterialPageRoute(builder: (context) => ApplyLeave()));
          //   },
          //   title: 'Apply',
          // ),
        ],
      ),
      body: Container(
        decoration: kBackgroundDesign(context),
        child: SingleChildScrollView(
            child: ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: tasks.length,
          separatorBuilder: (BuildContext context, int index) {
            return Container(height: 3, color: Colors.transparent);
          },
          itemBuilder: (context, index) {
            return taskElement(
              task: tasks[index],
              iconPress: () {
                _showarchiveDialog(context, tasks[index]);
              },
              onPress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TaskDetailsScreen()));
              },
            );
          },
        )),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:srr_management/Screens/task/taskModel.dart';
import 'package:srr_management/theme/style.dart';

class IssuedTaskScreen extends StatefulWidget {
  const IssuedTaskScreen({super.key});

  @override
  State<IssuedTaskScreen> createState() => _IssuedTaskScreenState();
}

class _IssuedTaskScreenState extends State<IssuedTaskScreen> {
  final List<Task> tasks = [
    Task(
        name: 'Task 1',
        description: 'Description of Task 1',
        imagePath: 'assets/task1_image.jpg',
        isFlagged: true,
        issueDescription: "Need more input"
        ),
    Task(
        name: 'Task 2',
        description: 'Description of Task 2',
        imagePath: 'assets/task2_image.jpg',
         issueDescription: "Need more input",
        isFlagged: true),
    Task(
        name: 'Task 3',
        description: 'Description of Task 3',
        imagePath: 'assets/task3_image.jpg',
         issueDescription: "Need to discuss with team",
        isFlagged: true),
    Task(
        name: 'Task 3',
        description: 'Description of Task 3',
        imagePath: 'assets/task3_image.jpg',
         issueDescription: "Need a laptop",
        isFlagged: true),
  ];
  void _editTaskDescription(BuildContext context, int index) {
    TextEditingController _controller =
        TextEditingController(text: tasks[index].issueDescription);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Task Issue Description'),
          content: TextField(
            controller: _controller,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  tasks[index].issueDescription = _controller.text;
                });
                Navigator.pop(context);
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void _unflagTask(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Unflag Task'),
          content: Text('Are you sure you want to unflag this task?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  tasks.removeAt(index);
                });
                Navigator.pop(context);
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "My Issues",
      )),
      body: Container(
        decoration: kBackgroundDesign(context),
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 2,
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(tasks[index].name,style:kBoldStyle() ,),
                    TextField(
                      readOnly: true,
                      controller:
                          TextEditingController(text: tasks[index].issueDescription),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        _editTaskDescription(context, index);
                      },
                    ),
                    IconButton(
                      icon: Icon(tasks[index].isFlagged
                          ? Icons.flag
                          : Icons.outlined_flag),
                      onPressed: () {
                        _unflagTask(context, index);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

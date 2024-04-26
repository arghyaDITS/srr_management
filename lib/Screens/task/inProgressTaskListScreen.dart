import 'package:flutter/material.dart';
import 'package:srr_management/Screens/task/taskModel.dart';
import 'package:srr_management/theme/style.dart';

class InProgressTaskListScreen extends StatefulWidget {
  @override
  _InProgressTaskListScreenState createState() => _InProgressTaskListScreenState();
}

class _InProgressTaskListScreenState extends State<InProgressTaskListScreen> {
  List<Task> tasks = [
    Task(name: 'Task 1', progress: 0.3,description: "Description of task 1"),
    Task(name: 'Task 2', progress: 0.6,description: "Description of task 1"),
    Task(name: 'Task 3', progress: 0.9,description: "Description of task 1"),
    Task(name: 'Task 4', progress: 1.0,description: "Description of task 1"),
    Task(name: 'Task 5', progress: 0.6,description: "Description of task 1"),
    Task(name: 'Task 10', progress: 0.0,description: "Description of task 1"),
    Task(name: 'Task 13', progress: 0.3,description: "Description of task 1"),
    Task(name: 'Task 12', progress: 0.3,description: "Description of task 1"),
    Task(name: 'Task 45', progress: 0.4,description: "Description of task 1"),
    Task(name: 'Task 12', progress: 0.5,description: "Description of task 1"),
    Task(name: 'Task 222', progress: 0.6,description: "Description of task 1"),
    Task(name: 'Task 30', progress: 0.9,description: "Description of task 1"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress TaskList'),
      ),
      body: Container(
        decoration: kBackgroundDesign(context),
        child: ListView.separated(
          //shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
        //  physics: const NeverScrollableScrollPhysics(),
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return Card(
              color:  const Color.fromARGB(255, 99, 212, 207),
        elevation: 2,
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(tasks[index].name,style: kBoldStyle(),),
                    Text(tasks[index].description!,style: k16Style(),),
                  ],
                ),
                subtitle: LinearProgressIndicator(
                  minHeight:6.0,
                  value: tasks[index].progress,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(Color.fromARGB(144, 27, 75, 119)),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return kSpace(height: 10.0);
          },
        ),
      ),
    );
  }
}


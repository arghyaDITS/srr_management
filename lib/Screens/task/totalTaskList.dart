import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:srr_management/Screens/task/editTask.dart';
import 'package:srr_management/Screens/task/taskDetailScreen.dart';
import 'package:srr_management/Screens/task/taskModel.dart';
import 'package:srr_management/components/buttons.dart';
import 'package:srr_management/theme/style.dart';

class TotalTaskList extends StatefulWidget {
  final String completed;
  const TotalTaskList({super.key, required this.completed});

  @override
  State<TotalTaskList> createState() => _TotalTaskListState();
}

class _TotalTaskListState extends State<TotalTaskList> {
  final List<Task> tasks = [
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
  ];
  taskElement({task, onPress, color}) {
    return Card(
      color:
          task.isDone ? const Color.fromARGB(255, 197, 198, 199) : Colors.white,
      elevation: 2,
      child: ListTile(
        leading: Image.asset(
          'images/logo.jpg',
          width: 50,
          height: 50,
        ),
        title: Text(task.name),
        subtitle: Text(task.description),
        trailing: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.arrow_forward),
          ],
        ),
        onTap: onPress,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
      ),
      body: Container(
        decoration: kBackgroundDesign(context),
        child: SingleChildScrollView(
            child: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: tasks.length,
              separatorBuilder: (BuildContext context, int index) {
                return Container(height: 10, color: Colors.transparent);
              },
              itemBuilder: (context, index) {
                return widget.completed == 'Completed'
                    ? tasks[index].isDone == true
                        ? taskElement(
                            task: tasks[index],
                            onPress: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const TaskDetailsScreen()));
                            },
                          )
                        : Container()
                    : taskElement(
                        task: tasks[index],
                        onPress: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const TaskDetailsScreen()));
                        },
                      );
              },
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2,
            )
          ],
        )),
      ),
    );
  }
}

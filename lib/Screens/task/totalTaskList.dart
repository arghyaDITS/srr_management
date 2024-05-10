import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:srr_management/Screens/task/editTask.dart';
import 'package:srr_management/Screens/task/taskDetailScreen.dart';
import 'package:srr_management/Screens/task/taskModel.dart';
import 'package:srr_management/components/buttons.dart';
import 'package:srr_management/components/util.dart';
import 'package:srr_management/services/apiEndpoint.dart';
import 'package:srr_management/services/serViceManager.dart';
import 'package:srr_management/theme/style.dart';
import 'package:http/http.dart' as http;

class TotalTaskList extends StatefulWidget {
  final String completed;
  const TotalTaskList({super.key, required this.completed});

  @override
  State<TotalTaskList> createState() => _TotalTaskListState();
}

class _TotalTaskListState extends State<TotalTaskList> {
  final StreamController _streamController = StreamController();

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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(ServiceManager.userID.toString());
    getUserTotalTaskData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _streamController.close();
  }

  taskElement({taskName, desc, status, color, onPress}) {
    return Card(
      color: status == 'pending' || status == 'yet to start'
          ?Colors.white
          :  const Color.fromARGB(255, 197, 198, 199),
      elevation: 2,
      child: ListTile(
        leading: Image.asset(
          'images/logo.jpg',
          width: 50,
          height: 50,
        ),
        title: Text(taskName),
        subtitle: Text(desc),
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

  getUserTotalTaskData() async {
    String url = APIData.getUserTotalTask;
    print(url);

    var res = await http.post(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${ServiceManager.tokenID}',
    }, body: {
      'user_id': 23.toString() //ServiceManager.userID
    });
    print(res.statusCode);
    if (res.statusCode == 200) {
      print(res.body);

      var data = jsonDecode(res.body);

      _streamController.add(data['task']);
    }
    return 'Success';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
      ),
      body: StreamBuilder(
          stream: _streamController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;
              print(data.toString());
              print(data.length);

              return Container(
                height: MediaQuery.of(context).size.height,
                decoration: kBackgroundDesign(context),
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: data.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return Container(height: 10, color: Colors.transparent);
                      },
                      itemBuilder: (context, index) {
                        return widget.completed == 'Completed'
                            ? data[index]['status'] == 'pending' ||
                                    data[index]['yet to start']
                                ? taskElement(
                                    taskName: data[index]['title'],
                                    desc: data[index]['description'],
                                    status: data[index]['status'],
                                    onPress: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                   TaskDetailsScreen(taskId:  data[index]['id'])));
                                    },
                                  )
                                : Container()
                            : taskElement(
                                taskName: data[index]['title'],
                                desc: data[index]['description'],
                                status: data[index]['status'],
                                onPress: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                               TaskDetailsScreen(taskId:  data[index]['id'])));
                                },
                              );
                      },
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 2,
                    )
                  ],
                )),
              );
            }
            return const Center(child: LoadingIcon());
          }),
    );
  }
}

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:srr_management/Screens/Home/home.dart';
import 'package:srr_management/Screens/task/taskDetailScreen.dart';
import 'package:srr_management/Screens/task/taskModel.dart';
import 'package:srr_management/components/buttons.dart';
import 'package:srr_management/components/util.dart';
import 'package:srr_management/services/apiEndpoint.dart';
import 'package:srr_management/services/serViceManager.dart';
import 'package:http/http.dart' as http;
import 'package:srr_management/theme/style.dart';

class ArchivedTaskList extends StatefulWidget {
  const ArchivedTaskList({super.key});

  @override
  State<ArchivedTaskList> createState() => _ArchivedTaskListState();
}

class _ArchivedTaskListState extends State<ArchivedTaskList> {
  bool isLoading = false;
  final StreamController _streamController = StreamController();

  @override
  void initState() {
    super.initState();
    getArchivedTaskList();
  }

  void _showUnarchiveDialog(BuildContext context,taskId) {
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
                unArchiveTask(taskId);
                Navigator.of(context).pop();
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }
  unArchiveTask(taskId) async {
    setState(() {
      isLoading = true;
    });
    String url = APIData.archivedTask;
    print(url);

    var res = await http.post(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${ServiceManager.tokenID}',
    }, body: {
      'id': taskId.toString(),
      'archive': '0'
    });
    print(res.statusCode);
    if (res.statusCode == 200) {
      //  print(res.body);

      var data = jsonDecode(res.body);
      print(data.toString());
      setState(() {
        isLoading = false;
      });
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => Home()), (route) => false);
    }
    return 'Success';
  }

  taskElement({taskName,taskDesc, onIconPress, color,onTap}) {
    return Card(
      color: Color.fromARGB(255, 175, 212, 247),
      elevation: 2,
      child: ListTile(
        leading: Image.asset(
          'images/logo.jpg',
          width: 50,
          height: 50,
        ),
        title: Text(taskName),
        subtitle: Text(taskDesc),
        trailing: IconButton(
          icon: Icon(Icons.unarchive),
          onPressed: onIconPress,
        ),
        onTap: onTap,
      ),
    );
  }

  void _unarchiveTask(task) {
    setState(() {
     // archivedTasks.remove(task);
      // Add the unarchived task to a new list or perform any other actions as needed
    });
  }

  getArchivedTaskList() async {
    setState(() {
      isLoading = true;
    });
    String url = APIData.archivedTaskListForUser;
    print(url);

    var res = await http.post(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${ServiceManager.tokenID}',
    }, body: {
      'user_id': ServiceManager.userID
    });
    print(res.statusCode);
    if (res.statusCode == 200) {
      //  print(res.body);

      var data = jsonDecode(res.body);
      print(data.toString());
      _streamController.add(data['task']);
      setState(() {
        isLoading = false;
      });
    }
    return 'Success';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Archived Tasks'),
      ),
      body: Container(
        decoration: kBackgroundDesign(context),
        child: StreamBuilder(
            stream: _streamController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var snapData = snapshot.data;
        
                return  snapData.isNotEmpty? Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: kBackgroundDesign(context),
                  child: ListView.builder(
                    itemCount: snapData.length,
                    itemBuilder: (context, index) {
                      return taskElement(
                         taskName:snapData[index]['title'],
                         taskDesc:snapData[index]['description'],
                         
                          onTap: (){ Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TaskDetailsScreen(
                                                  isArchived: true,
                                                    taskId: snapData[index]['id'])));},
                          onIconPress: () {
                            _showUnarchiveDialog(context,snapData[index]['id']);
                          });
                    },
                  ),
                ):Center(child: Text("No archived task"),);
              }
              return Center(
                child: LoadingIcon(),
              );
            }),
      ),
    );
  }
}

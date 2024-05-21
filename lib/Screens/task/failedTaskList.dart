import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:srr_management/Screens/task/taskDetailScreen.dart';
import 'package:srr_management/components/util.dart';
import 'package:srr_management/services/apiEndpoint.dart';
import 'package:srr_management/services/serViceManager.dart';
import 'package:srr_management/theme/style.dart';

class FailedTaskList extends StatefulWidget {
  final String status;
  const FailedTaskList({super.key, required this.status});

  @override
  State<FailedTaskList> createState() => _FailedTaskListState();
}

class _FailedTaskListState extends State<FailedTaskList> {
  final StreamController _streamController = StreamController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.status);
    getFailedTaskData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _streamController.close();
  }

  taskElement({taskName, desc, color, onPress}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color:Color.fromARGB(255, 235, 202, 202),
          border: Border.all(color: Colors.grey, width: 1.5),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(15.0),
          onTap: onPress,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundImage: AssetImage('images/failed_task.png'),
                  backgroundColor: Colors.transparent,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        taskName,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: 
                               Color.fromARGB(255, 115, 1, 1),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        desc,
                        style: TextStyle(
                          fontSize: 14,
                          color: const Color.fromARGB(137, 106, 3, 3),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Icon(
                  Icons.arrow_forward_ios,
                  color:  Colors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getFailedTaskData() async {
    String url = "${APIData.getFailedTask}/${ServiceManager.userID}";
    print(url);

    var res = await http.get(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${ServiceManager.tokenID}',
    });
    print(res.statusCode);
    if (res.statusCode == 200) {
      print(res.body);

      var data = jsonDecode(res.body);

      _streamController.add(data['failed_task']);
    }
    return 'Success';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Failed Task"),
            //widget.status == 'Completed' ? 'Completed Task' : 'My Total Tasks'),
      ),
      body: Container(
        decoration: kBackgroundDesign(context),
        child: StreamBuilder(
            stream: _streamController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data;
                // print(data.toString());
                // print(data.length);
                // List data = [];
                // if (widget.status == null || widget.status == 'Total') {
                //   data = snapData;
                // } else {
                //   for (var item in snapData) {
                //     if (item['status'] == widget.status) {
                //       data.add(item);
                //     }
                //   }
                // }

                return data.isNotEmpty
                    ? Container(
                        height: MediaQuery.of(context).size.height,
                        decoration: kBackgroundDesign(context),
                        child: SingleChildScrollView(
                            child: Column(
                          children: [
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: data.length,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return Container(
                                    height: 10, color: Colors.transparent);
                              },
                              itemBuilder: (context, index) {
                                return taskElement(
                                  taskName: data[index]['title'],
                                  desc: data[index]['description'],
                                 // status: data[index]['status'],
                                  onPress: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TaskDetailsScreen(
                                                    taskId: data[index]
                                                        ['id'])));
                                  },
                                );
                              },
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height / 2,
                            )
                          ],
                        )),
                      )
                    : Center(
                        child: Text("No task to show"),
                      );
              }
              return const Center(child: LoadingIcon());
            }),
      ),
    );
  }
}

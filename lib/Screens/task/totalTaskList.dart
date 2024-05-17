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
  final String status;
  const TotalTaskList({super.key, required this.status});

  @override
  State<TotalTaskList> createState() => _TotalTaskListState();
}

class _TotalTaskListState extends State<TotalTaskList> {
  final StreamController _streamController = StreamController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.status);
    getUserTotalTaskData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _streamController.close();
  }

  taskElement({taskName, desc, status, color, onPress}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: status != 'Completed'
              ? Colors.white
              : const Color.fromARGB(255, 197, 198, 199),
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
                  radius: 25,
                  backgroundImage: AssetImage('images/logo.jpg'),
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
                          color: status == 'Completed'
                              ? Colors.grey
                              : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        desc,
                        style: TextStyle(
                          fontSize: 14,
                          color: status == 'Completed'
                              ? Colors.grey
                              : Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Icon(
                  Icons.arrow_forward_ios,
                  color: status == 'Completed' ? Colors.grey : Colors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  taskElement2({taskName, desc, status, color, onPress}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Card(
        color: status != 'Completed'
            ? Colors.white
            : const Color.fromARGB(255, 197, 198, 199),
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
      'user_id': ServiceManager.userID
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
        title: Text(
            widget.status == 'Completed' ? 'Completed Task' : 'My Total Tasks'),
      ),
      body: Container(
        decoration: kBackgroundDesign(context),
        child: StreamBuilder(
            stream: _streamController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var snapData = snapshot.data;
                // print(data.toString());
                // print(data.length);
                List data = [];
                if (widget.status == null || widget.status == 'Total') {
                  data = snapData;
                } else {
                  for (var item in snapData) {
                    if (item['status'] == widget.status) {
                      data.add(item);
                    }
                  }
                }

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
                                  status: data[index]['status'],
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

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:srr_management/Screens/task/taskDetailScreen.dart';
import 'package:srr_management/Screens/task/taskModel.dart';
import 'package:srr_management/components/util.dart';
import 'package:srr_management/services/apiEndpoint.dart';
import 'package:srr_management/services/serViceManager.dart';
import 'package:srr_management/theme/style.dart';
import 'package:http/http.dart' as http;

class InProgressTaskListScreen extends StatefulWidget {
  @override
  _InProgressTaskListScreenState createState() =>
      _InProgressTaskListScreenState();
}

class _InProgressTaskListScreenState extends State<InProgressTaskListScreen> {
  final StreamController _streamController = StreamController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTodaysTaskList();
  }
  getTodaysTaskList() async {
    String url = APIData.todaysTaskListForUser;
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
        title: const Text('Progress TaskList'),
      ),
      body: Container(
        decoration: kBackgroundDesign(context),
        child: StreamBuilder(
            stream: _streamController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data;

                return data.isNotEmpty
                    ? Container(
                        decoration: kBackgroundDesign(context),
                        child: ListView.separated(
                          //shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 5.0),
                          //  physics: const NeverScrollableScrollPhysics(),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return Card(
                              color: Color.fromARGB(255, 245, 236, 255),
                              elevation: 2,
                              child: ListTile(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TaskDetailsScreen(
                                                  taskId: data[index]['id'])));
                                },
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data[index]['title'],
                                      style: kBoldStyle(),
                                    ),
                                    Text(
                                       data[index]['description'],
                                      style: k16Style(),
                                    ),
                                  ],
                                ),
                                // subtitle: LinearProgressIndicator(
                                //   minHeight: 6.0,
                                //   value: tasks[index].progress,
                                //   backgroundColor: Colors.grey[300],
                                //   valueColor:
                                //       const AlwaysStoppedAnimation<Color>(
                                //           Color.fromARGB(144, 27, 75, 119)),
                                // ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return kSpace(height: 10.0);
                          },
                        ),
                      )
                    : Center(
                        child: Text("No task for today!"),
                      );
              }
              return Center(
                child: LoadingIcon(),
              );
            }),
      ),
    );
  }
}

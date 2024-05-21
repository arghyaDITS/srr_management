import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:srr_management/components/util.dart';
import 'package:srr_management/services/apiEndpoint.dart';
import 'package:srr_management/services/serViceManager.dart';
import 'package:srr_management/theme/style.dart';
import 'package:http/http.dart' as http;

class IssuedTaskScreen extends StatefulWidget {
  bool? isAdmin;
  
   IssuedTaskScreen({super.key,this.isAdmin});

  @override
  State<IssuedTaskScreen> createState() => _IssuedTaskScreenState();
}

class _IssuedTaskScreenState extends State<IssuedTaskScreen> {
  bool isLoading = false;
  final StreamController _streamController = StreamController();
  @override
  void initState() {
    super.initState();
    print(widget.isAdmin.toString());
    widget.isAdmin==true? getIssueList():getUserIssueList();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _streamController.close();
  }

  void _unflagTask(BuildContext context, issueId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Unflag Task'),
          content: const Text('Are you sure you want to unflag this task?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                resolveIssue(issueId);
                Navigator.pop(context);
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  getIssueList() async {
    print("AdminIssueList");
    setState(() {
      isLoading = true;
    });
    String url = APIData.getIssue;
    print(url);

    var res = await http.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${ServiceManager.tokenID}',
      },
    );
    print(res.statusCode);
    if (res.statusCode == 200) {
      print(res.body);
      var data = jsonDecode(res.body);
      print(data.toString());
      //for (var user in data) {
      // _userList.add(user['name']);
      //}

      setState(() {
        isLoading = false;
      });

      _streamController.add(data['data']);
    }
    return 'Success';
  }
  getUserIssueList() async {
    print("userIssueList");
    setState(() {
      isLoading = true;
    });
    String url = "${APIData.getIssueForUser}/${ServiceManager.userID}";
    print(url);

    var res = await http.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${ServiceManager.tokenID}',
      },
    );
    print(res.statusCode);
    if (res.statusCode == 200) {
      print(res.body);
      var data = jsonDecode(res.body);
      print(data.toString());
      //for (var user in data) {
      // _userList.add(user['name']);
      //}

      setState(() {
        isLoading = false;
      });

      _streamController.add(data['data']);
    }
    return 'Success';
  }

  resolveIssue(issueId) async {
    setState(() {
      isLoading = true;
    });
    String url = "${APIData.fixIssue}/$issueId";
    print(url);
    var res = await http.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${ServiceManager.tokenID}',
      },
    );
    print(res.statusCode);
    if (res.statusCode == 200) {
      print(res.body);
      var data = jsonDecode(res.body);
      print(data.toString());
       widget.isAdmin==true? getIssueList():getUserIssueList();
      setState(() {
        isLoading = false;
      });

     // _streamController.add(data['data']);
    }
    return 'Success';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:  Text(
       widget.isAdmin==true? "Total Issues":"My issues",
      )),
      body: StreamBuilder(
          stream: _streamController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;

              return data.isNotEmpty? Container(
                decoration: kBackgroundDesign(context),
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 2,
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Task: ",
                                  style: kBoldStyle(),
                                ),
                                Text(
                                 data[index]['get_task']==null?'': data[index]['get_task']['title'],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Issue Notes:",
                                  style: kBoldStyle(),
                                ),
                                Text(
                                  data[index]['issue_note']??'',
                                ),
                              ],
                            ),
                           widget.isAdmin==true? Row(
                              children: [
                                Text("Created By:", style: kBoldStyle()),
                                Text(
                                  data[index]['get_user']['name'],
                                )
                              ],
                            ):Container()
                            // TextField(
                            //   readOnly: true,
                            //   controller: TextEditingController(
                            //       text: tasks[index].issueDescription),
                            //   decoration: InputDecoration(
                            //     border: InputBorder.none,
                            //   ),
                            // ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // IconButton(
                            //   icon: Icon(Icons.edit),
                            //   onPressed: () {
                            //     _editTaskDescription(context, index);
                            //   },
                            // ),
                            IconButton(
                              icon: const Icon(color: Colors.red, Icons.flag),
                              onPressed: () {
                                _unflagTask(context, data[index]['id']);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ):Container(
                decoration: kBackgroundDesign(context),
                child: Center(child: Text("No issue yet",style: kBoldStyle(),),));
            }
            return const Center(child: LoadingIcon());
          }),
    );
  }
}

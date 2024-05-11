import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:srr_management/Screens/Home/home.dart';
import 'package:srr_management/Screens/Leave/component/approvalPopUp.dart';
import 'package:srr_management/Screens/task/totalTaskList.dart';
import 'package:srr_management/components/buttons.dart';
import 'package:srr_management/components/util.dart';
import 'package:srr_management/services/apiEndpoint.dart';
import 'package:srr_management/services/serViceManager.dart';
import 'package:srr_management/theme/colors.dart';
import 'package:srr_management/theme/style.dart';
import 'package:http/http.dart' as http;

class TaskDetailsScreen extends StatefulWidget {
  int? taskId;
  bool? isArchived;
  TaskDetailsScreen({super.key, this.taskId, this.isArchived});

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  final StreamController _streamController = StreamController();
  TextEditingController issueController = TextEditingController();

  String _dropdownValue = 'Yet to start';
  bool isTooltipVisible = false;
  bool isLoading = false;
  String issue = '';
  @override
  void initState() {
    super.initState();
    getTaskData();
  }

  getTaskData() async {
    setState(() {
      isLoading = true;
    });
    String url = APIData.getTaskById;
    print(url);

    var res = await http.post(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${ServiceManager.tokenID}',
    }, body: {
      'task_id': widget.taskId.toString()
    });
    print(res.statusCode);
    if (res.statusCode == 200) {
      print(res.body);

      var data = jsonDecode(res.body);
      _dropdownValue = data['task']['status'] == 'pending'
          ? 'Yet to start'
          : data['task']['status'] == 'completed'
              ? 'Completed'
              : "In Progress";

      _streamController.add(data['task']);
      setState(() {
        isLoading = false;
      });

      //   _streamController.add(data['task']);
    }
    return 'Success';
  }

  changeTaskStatus(status) async {
    setState(() {
      isLoading = true;
    });
    String url = "${APIData.changeTaskStatus}/${widget.taskId}/$status";
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
      //  print(res.body);

      var data = jsonDecode(res.body);
      setState(() {
        isLoading = false;
      });

      //   _streamController.add(data['task']);
    }
    return 'Success';
  }

  createIssue(context) async {
    setState(() {
      isLoading = true;
    });
    String url = APIData.createIssue;
    print(url);

    var res = await http.post(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${ServiceManager.tokenID}',
    }, body: {
      'user_id': ServiceManager.userID,
      'task_id': widget.taskId.toString(),
      'issue_note': issueController.text
    });
    print(res.statusCode);
    if (res.statusCode == 200) {
      //  print(res.body);

      var data = jsonDecode(res.body);
      print(data.toString());
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();

      //   _streamController.add(data['task']);
    }
    return 'Success';
  }

  archiveTask() async {
    setState(() {
      isLoading = true;
    });
    String url = APIData.archivedTask;
    print(url);

    var res = await http.post(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${ServiceManager.tokenID}',
    }, body: {
      'id': widget.taskId.toString(),
      'archive': widget.isArchived==true?'0':'1'
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

  Future<void> _showIssueDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Report Issue'),
          content: TextField(
            controller: issueController,
            decoration: const InputDecoration(
              hintText: 'Enter issue...',
            ),
            onChanged: (value) {
              issue = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // Save the issue and close the dialog
                // _saveIssue(context);
                createIssue(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _saveIssue(BuildContext context) {
    // Here you can handle saving the issue, for now let's just print it
    print('Issue: $issue');
    Navigator.of(context).pop(); // Close the dialog
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
      ),
      body: StreamBuilder(
          stream: _streamController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;
              print(data.toString());

              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        decoration: kBackgroundDesign(context),
                        height: MediaQuery.of(context).size.height / 1.1,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                            padding: const EdgeInsets.only(
                                top: 30.0, bottom: 250, left: 30, right: 30),
                            child: Card(
                              elevation: 4,
                              margin: const EdgeInsets.all(8),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Task ID: ${data['title']}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text(
                                          'Task Description:  ',
                                          style: kBoldStyle(),
                                        ),
                                        Text(' ${data['description']}'),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      children: [
                                        Text(
                                          "Priority: ",
                                          style: kBoldStyle(),
                                        ),
                                        Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              color: data['priority'] == 'high'
                                                  ? const Color.fromARGB(
                                                      255, 240, 134, 126)
                                                  : data['priority'] == 'low'
                                                      ? const Color.fromARGB(
                                                          255, 109, 207, 112)
                                                      : const Color.fromARGB(
                                                          255, 190, 181, 96),
                                              borderRadius: BorderRadius.circular(
                                                  8), // Adjust border radius as needed
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 2,
                                                  blurRadius: 4,
                                                  offset: const Offset(0,
                                                      3), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Text(
                                              data['priority'],
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 2,
                                                  blurRadius: 4,
                                                  offset: const Offset(0,
                                                      3), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'Start Date:',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  DateFormat('EEE, d/M/y')
                                                      .format(DateTime.parse(
                                                          data['start_date']))
                                                      .toString(), // Replace with your start date
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey[800],
                                                  ),
                                                ),
                                                const SizedBox(height: 16),
                                                const Text(
                                                  'End Date:',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  DateFormat('EEE, d/M/y')
                                                      .format(DateTime.parse(
                                                          data['end_date']))
                                                      .toString(), // Replace with your start date
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey[800],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.spaceAround,
                                    //   children: [
                                    //     ElevatedButton(
                                    //       onPressed: () {
                                    //         // Handle archive button click
                                    //       },
                                    //       child: const Text('Archive'),
                                    //     ),
                                    //     ElevatedButton(
                                    //       onPressed: () {
                                    //         // Handle start button click
                                    //       },
                                    //       child: const Text('Start'),
                                    //     ),
                                    //   ],
                                    // ),
                                    Row(
                                      children: [
                                        Text(
                                          "Select task Status:",
                                          style: kBoldStyle(),
                                        ),
                                        DropdownButton<String>(
                                          value: _dropdownValue != ''
                                              ? _dropdownValue
                                              : null,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              _dropdownValue = newValue!;
                                            });
                                            changeTaskStatus(_dropdownValue);
                                          },
                                          items: <String>[
                                            'Yet to start',
                                            'Completed',
                                            'In Progress'
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 8),
                                                  width:
                                                      100, // Adjust the width as needed
                                                  alignment: Alignment.center,
                                                  child: Text(value)),
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Text(
                                                textScaleFactor:
                                                    0.8, // Adjust the scaling factor as needed
                                                overflow: TextOverflow.ellipsis,
                                                "Having Issue, Raise Flag!"),
                                            IconButton(
                                              icon: const Icon(Icons.flag),
                                              color: Colors.red,
                                              onPressed: () {
                                                _showIssueDialog(context);
                                              },
                                            ),
                                          ],
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              declinePopUp(context,widget.isArchived==true?'Unarchive': "archive",
                                                  onClickYes: () {
                                                archiveTask();
                                                //--
                                                // deleteTask(
                                                //     data[index]
                                                //         ['id']);

                                                Navigator.pop(context);
                                              });
                                            },
                                            icon: widget.isArchived == true
                                                ? Icon(Icons.unarchive)
                                                : Icon(Icons.archive))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ))),
                  ],
                ),
              );
            }
            return Container(child: const LoadingIcon());
          }),
    );
  }
}

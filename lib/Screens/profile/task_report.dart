import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:srr_management/components/util.dart';
import 'package:srr_management/services/apiEndpoint.dart';
import 'package:srr_management/services/serViceManager.dart';
import 'package:srr_management/theme/style.dart';
import 'package:http/http.dart' as http;

class TaskReportScreen extends StatefulWidget {
  TaskReportScreen({super.key});

  @override
  State<TaskReportScreen> createState() => _TaskReportScreenState();
}

class _TaskReportScreenState extends State<TaskReportScreen> {
  bool isLoading = false;
  String pending = "";
  String inProgress = "";
  String completed = "";
  String faild = "";

  @override
  void initState() {
    super.initState();
    getReportData();
  }

  getReportData() async {
    setState(() {
      isLoading = true;
    });
    String url = "${APIData.taskCountDataforUser}/${ServiceManager.userID}";
    print(url);
    await Future.delayed(Duration(seconds: 1));
    var res = await http.get(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${ServiceManager.tokenID}',
    });
    print(res.statusCode);
    if (res.statusCode == 200) {
      print(res.body);

      var data = jsonDecode(res.body);
      print(data);
      pending = data['yet_to_start_task'].toString();
      inProgress = data['in_progress_task'].toString();
      completed = data['completed_task'].toString();
      faild = data['failed_task'].toString();
    }

    //   _streamController.add(data['task']);
    setState(() {
      isLoading = false;
    });
    return 'Success';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Report'),
      ),
      body: isLoading == true
          ? Center(
              child: LoadingIcon(),
            )
          : Container(
              decoration: kBackgroundDesign(context),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Task Report',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        children: [
                          _buildTaskCard('Yet to Start', pending, Colors.blue),
                          _buildTaskCard(
                              'In Progress Tasks', inProgress, Colors.green),
                          _buildTaskCard(
                              'Completed Tasks', completed, Colors.orange),
                          _buildTaskCard('Failed Tasks', faild, Colors.red),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildTaskCard(String title, String count, Color color) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 4.0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: color.withOpacity(0.1),
        ),
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$count',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

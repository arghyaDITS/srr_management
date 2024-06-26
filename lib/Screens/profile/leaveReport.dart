import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:srr_management/components/util.dart';
import 'package:srr_management/services/apiEndpoint.dart';
import 'package:srr_management/services/serViceManager.dart';
import 'package:srr_management/theme/style.dart';
import 'package:http/http.dart' as http;

class LeaveReportScreen extends StatefulWidget {
  String? userId;
  LeaveReportScreen({super.key,  this.userId});
  @override
  State<LeaveReportScreen> createState() => _LeaveReportScreenState();
}

class _LeaveReportScreenState extends State<LeaveReportScreen> {
  bool isLoading = false;
  final StreamController _streamController = StreamController();
  String accepted = "";
  String declined = "";
  String pending = "";
  String total="";

  @override
  void initState() {
    super.initState();
    getLeaveReportData(widget.userId);
    getMonthName(12);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _streamController.close();
  }

  String getMonthName(int monthNumber) {
    // Creating a DateTime object with the year 2022 and the given month number
    DateTime dateTime = DateTime(2022, monthNumber);

    // Formatting the DateTime object to get the month name
    String monthName = DateFormat('MMMM').format(dateTime);
    return monthName;
  }

  getLeaveReportData(userId) async {
    setState(() {
      isLoading = true;
    });
    String url = "${APIData.leaveReportForUser}/$userId";
    print(url);
    await Future.delayed(Duration(seconds: 1));

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
      print(data);
      pending = data['data']['pendingLeave'].toString();
      accepted = data['data']['approveLeave'].toString();
      declined = data['data']['declineLeave'].toString();
     

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
        title: const Text('Leave Report'),
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
                          _buildLeaveCard('Pending Leave', pending, Colors.blue),
                          _buildLeaveCard(
                              'Accepted Leave', accepted, Colors.green),
                          _buildLeaveCard(
                              'Declined Leave', declined, Colors.orange),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildLeaveCard(String title, String count, Color color) {
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

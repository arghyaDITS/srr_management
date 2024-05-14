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
  @override
  State<LeaveReportScreen> createState() => _LeaveReportScreenState();
}

class _LeaveReportScreenState extends State<LeaveReportScreen> {
  bool isLoading = false;
  final StreamController _streamController = StreamController();

  @override
  void initState() {
    super.initState();
    getLeaveReportData(ServiceManager.userID);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leave Report'),
      ),
      body: StreamBuilder(
          stream: _streamController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;

              return data.isNotEmpty
                  ? Container(
                      decoration: kBackgroundDesign(context),
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color.fromARGB(255, 185, 139, 200),
                                  Color.fromARGB(255, 85, 229, 255)
                                ], // Gradient colors
                              ),
                              borderRadius:
                                  BorderRadius.circular(15), // Rounded corners
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor:
                                    Colors.white, // White background for icon
                                child: Icon(Icons.calendar_today,
                                    color: Colors.blue), // Blue icon
                              ),
                              title: Text(
                                'Total leave in ${getMonthName(12)} of ${data[index]['year']} is ${data[index]['total_days']}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Container(
                      decoration: kBackgroundDesign(context),
                      child: Center(
                        child: Text(
                          "No report to show",
                          style: kBoldStyle(),
                        ),
                      ));
            }
            return const Center(child: LoadingIcon());
          }),
    );
  }
}

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:srr_management/Screens/Leave/applyLeave.dart';
import 'package:srr_management/Screens/task/editTask.dart';
import 'package:srr_management/components/buttons.dart';
import 'package:srr_management/components/util.dart';
import 'package:srr_management/services/apiEndpoint.dart';
import 'package:srr_management/services/serViceManager.dart';
import 'package:srr_management/theme/colors.dart';
import 'package:srr_management/theme/style.dart';

class MyLeave extends StatefulWidget {
  const MyLeave({Key? key}) : super(key: key);

  @override
  State<MyLeave> createState() => _MyLeaveState();
}

class _MyLeaveState extends State<MyLeave> {
  final StreamController _streamController = StreamController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLeaveData();
  }

  getLeaveData() async {
    print(ServiceManager.userID.toString());
    String url = APIData.userWiseLeave;
    var res = await http.get(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${ServiceManager.tokenID}',
    });
    print(res.statusCode);
    if (res.statusCode == 200) {
      print(res.body);
      var data = jsonDecode(res.body);
      _streamController.add(data['data']);
    }
    return 'Success';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Leave'),
        actions: [
          ArrowButton(
            onClick: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LeaveApplicationScreen()));
            },
            title: 'Apply',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // BarChartSample2(),

            StreamBuilder(
                stream: _streamController.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data;
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: data.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 15);
                      },
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: roundedContainerDesign(context),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text('Status: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600)),
                                    GestureDetector(
                                      onTap: () {
                                        // showModalBottomSheet<void>(
                                        //     shape: bottomSheetRoundedDesign(),
                                        //     context: context,
                                        //     builder: (BuildContext context) {
                                        //       return LeaveBottomSheet(
                                        //         stepPosition: data[index]
                                        //                     ['Status'] ==
                                        //                 'Approved'
                                        //             ? 3
                                        //             : data[index]['Status'] ==
                                        //                     'Rejected'
                                        //                 ? 2
                                        //                 : 1,
                                        //       );
                                        //     });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          // color: data[index]['Status'] ==
                                          //         'Approved'
                                          //     ? Colors.green.withOpacity(0.4)
                                          //     : data[index]['Status'] ==
                                          //             'Reject'
                                          //         ? Colors.red
                                          //             .withOpacity(0.4)
                                          //         : data[index]['Status'] ==
                                          //                 'Pending'
                                          //             ? Colors.orange
                                          //                 .withOpacity(0.4)
                                          //             : null
                                        ),
                                        child: Text(
                                          data[index]['status'] == 0
                                              ? 'Pending'
                                              : data[index]['status'] == 1
                                                  ? 'Accepted'
                                                  : 'Declined',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 17,
                                              color: data[index]['status'] == 0
                                                  ? const Color.fromARGB(
                                                      255, 241, 221, 37)
                                                  : data[index]['status'] == 1
                                                      ? Colors.green
                                                      : Colors.red),
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    data[index]['status'] == 0
                                        ? IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          LeaveApplicationScreen(
                                                            leaveId: data[index]
                                                                ['id'],
                                                          )));
                                            },
                                            icon: Icon(Icons.edit))
                                        : Container(),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: kMainColor.withOpacity(0.2),
                                  ),
                                  child: Text(data[index]['leave_type']),
                                ),
                                kSpace(),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text('Date From'),
                                          const Divider(thickness: 1),
                                          Text(DateFormat('yyyy-MM-dd')
                                              .format(DateTime.parse(
                                                  data[index]['from_date']))
                                              .toString())
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          const Text('Date to'),
                                          const Divider(thickness: 1),
                                          Text(DateFormat('yyyy-MM-dd')
                                              .format(DateTime.parse(
                                                  data[index]['to_date']))
                                              .toString()),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          const Text('Duaration'),
                                          const Divider(thickness: 1),
                                          Text(data[index]['total_days']
                                              .toString()),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return const LoadingIcon();
                }),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}

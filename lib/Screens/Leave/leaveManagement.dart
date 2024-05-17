import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:srr_management/Screens/Leave/component/approvalPopUp.dart';
import 'package:srr_management/components/util.dart';
import 'package:srr_management/services/apiEndpoint.dart';
import 'package:srr_management/services/serViceManager.dart';
import 'package:srr_management/theme/colors.dart';
import 'package:srr_management/theme/style.dart';

class LeaveManagement extends StatefulWidget {
  const LeaveManagement({Key? key}) : super(key: key);

  @override
  State<LeaveManagement> createState() => _LeaveManagementState();
}

class _LeaveManagementState extends State<LeaveManagement>
    with SingleTickerProviderStateMixin {
  final StreamController _streamController = StreamController();
  bool isLoading = false;
  bool leaveResposed = false;
  late TabController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getemployeeLeavesData();

    controller = TabController(length: 3, vsync: this);
  }

  getemployeeLeavesData() async {
    String url = APIData.getTotalLeaveList;
    print(url.toString());
    var res = await http.get(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${ServiceManager.tokenID}',
    });
    print(res.statusCode);
    if (res.statusCode == 200) {
      print(res.body);

      var data = jsonDecode(res.body);
      // if (!_streamController.isClosed) {

      // }
      _streamController.add(data['data']);
    }
    return 'Success';
  }

  sendLeaveApproval(leaveId, status) async {
    isLoading = true;

    try {
      String url = '${APIData.changeLeaveStatus}/$leaveId/$status';
      var res = await http.get(Uri.parse(url), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${ServiceManager.tokenID}',
      });
      print(res.statusCode);
      if (res.statusCode == 200) {
        print(res.body);
        setState(() {
          leaveResposed = true;
        });

        var data = jsonDecode(res.body);
      }
      return 'Success';
    } catch (e) {
      print(e.toString());
    } finally {
      getemployeeLeavesData();
      isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Leave Management'),
          bottom: TabBar(
            controller: controller,
            tabs: const [
              Tab(text: 'Pending'),
              Tab(text: 'Approved'),
              Tab(text: 'Rejected'),
            ],
          ),
        ),
        body: isLoading == false
            ? Container(
              decoration: kBackgroundDesign(context),
              child: StreamBuilder(
                  stream: _streamController.stream,
                  builder: (context, snapshot) {
                    print(snapshot.hasData.toString());
                    if (snapshot.hasData) {
                      var data = snapshot.data;
                      if (data.length > 0) {
                        return TabBarView(controller: controller, children: [
                          leaveManageMentBody(data, 0),
                          leaveManageMentBody(data, 1),
                          leaveManageMentBody(data, 2)
                        ]);
                      } else {
                        const Center(
                          child: Text("No Data"),
                        );
                      }
                    }
                    return Center(
                      child: Text("No Data"),
                    );
                  }),
            )
            : const LoadingIcon());
  }

  leaveManageMentBody(data, status) {
    return SingleChildScrollView(
      child: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: data.length, //data.length,
        itemBuilder: (context, index) {
          return data[index]['status'] == status
              ? Container(
                  decoration: roundedContainerDesign(context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            const SizedBox(width: 10.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data[index]['get_user']['name']),
                              ],
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: kMainColor.withOpacity(0.2),
                              ),
                              child: Text(data[index]['leave_type'].toString()),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        child: Row(
                          children: [
                            const Text("Leave Id:"),
                            Text(data[index]['id'].toString())
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: roundedContainerDesign(context)
                              .copyWith(boxShadow: [
                            BoxShadow(
                              color: kMainColor.withOpacity(0.5),
                              spreadRadius: 1.0,
                              blurRadius: 1.0,
                              offset: const Offset(1, 0),
                            ),
                          ]),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Text('Status: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600)),
                                  Text(
                                    data[index]['status'] == 0
                                        ? 'Pending'
                                        : data[index]['status'] == 1
                                            ? 'Accepted'
                                            : 'Declined',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17,
                                        color: data[index]['status'] == 0
                                            ? Color.fromARGB(255, 241, 221, 37)
                                            : data[index]['status'] == 1
                                                ? Colors.green
                                                : Colors.red),
                                  ),
                                ],
                              ),
                               Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Description: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600)),
                                  Expanded(
                                    child: Text(
                                      data[index]['leave_desc'] ,
                                     
                                    ),
                                  ),
                                ],
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
                                            .toString()),
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
                                        const Text('Leave Day'),
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
                      ),
                      leaveResposed == false||data[index]['status']==0
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    declinePopUp(context, "Decline",
                                        onClickYes: () {
                                      sendLeaveApproval(
                                          data[index]['id'].toString(), 2);
                                      Navigator.pop(context);
                                    });
                                  },
                                  child: const Text('Decline'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    declinePopUp(context, "Approve",
                                        onClickYes: () {
                                      sendLeaveApproval(
                                          data[index]['id'].toString(), 1);
                                      Navigator.pop(context);
                                    });
                                  },
                                  child: const Text('Approve'),
                                ),
                              ],
                            )
                          : Container(),
                         
                    ],
                  ),
                )
              : Container();
        },
        separatorBuilder: (BuildContext context, int index) {
          return kSpace(height: 10.0);
        },
      ),
    );
  }
}

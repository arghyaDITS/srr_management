import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:srr_management/components/util.dart';
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
    //getemployeeLeavesData();

    controller = TabController(length: 3, vsync: this);
  }

  getemployeeLeavesData() async {
    // String url = APIData.hrLeaveList;
    // var res = await http.post(Uri.parse(url), headers: {
    //   'Accept': 'application/json',
    //   'Authorization': 'Bearer ${ServiceManager.tokenID}',
    // }, body: {
    //   'emp_id': ServiceManager.userID,
    // });
    // print(res.statusCode);
    // if (res.statusCode == 200) {
    //   print(res.body);

    //   var data = jsonDecode(res.body);
    //   // if (!_streamController.isClosed) {
       
    //   // }
    //    _streamController.add(data['Leaves']);
    // }
    // return 'Success';
  }

  sendLeaveApproval(leaveId, status) async {
    // isLoading = true;

    // try {
    //   String url = APIData.leaveApproval;
    //   var res = await http.post(Uri.parse(url), headers: {
    //     'Accept': 'application/json',
    //     'Authorization': 'Bearer ${ServiceManager.tokenID}',
    //   }, body: {
    //     'leaveid': leaveId,
    //     'Status': status
    //   });
    //   print(res.statusCode);
    //   if (res.statusCode == 200) {
    //     print(res.body);
    //     setState(() {
    //       leaveResposed = true;
    //     });

    //     var data = jsonDecode(res.body);
    //   }
    //   return 'Success';
    // } catch (e) {
    //   print(e.toString());
    // } finally {
    //   isLoading = false;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Leave Management'),
          bottom: TabBar(
            controller: controller,
            tabs: const [
              Tab(text: 'Approved'),
              Tab(text: 'Rejected'),
              Tab(text: 'Pending'),
            ],
          ),
        ),
        body:Container(
          decoration: kBackgroundDesign(context),
           child:TabBarView(controller: controller, children: [
                      leaveManageMentBody('data', "Approved"),
                      leaveManageMentBody('data', "Rejected"),
                      leaveManageMentBody('data', "Pending")
                    ]))
        //  isLoading == false
        //     ? StreamBuilder(
        //         stream: _streamController.stream,
        //         builder: (context, snapshot) {
        //           if (snapshot.hasData) {
        //             var data = snapshot.data;
        //             return 
                   
            //       }
            //       return const LoadingIcon();
            //     })
            // : const LoadingIcon()
            );
  }

  // TabBarView(
  //         controller: controller,
  //         children: [
  //           leaveManageMentBody("Accept"),
  //           leaveManageMentBody("Reject"),
  //           leaveManageMentBody("Pending"),
  //         ],
  //       )

  leaveManageMentBody(data, status) {
    return SingleChildScrollView(
      child: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 10,//data.length,
        itemBuilder: (context, index) {
          return 
          
        //  data[index]['Status']==status?
          Container(
            decoration: roundedContainerDesign(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage:
                            AssetImage('images/img_blank_profile.png'),
                      ),
                      const SizedBox(width: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('name'),//data[index]['user_details']['name']),
                          Text('Designation',
                              // data[index]['user_details']['Designation']
                              //         .toString() ??
                              //     '',
                              style: k14Text()),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: kMainColor.withOpacity(0.2),
                        ),
                        child: const Text('LeaveType'),//data[index]['LeaveType']),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Row(
                    children: [
                      Text("Leave Id:"),
                      Text('1'),//data[index]['id'].toString())
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration:
                        roundedContainerDesign(context).copyWith(boxShadow: [
                      BoxShadow(
                        color: kMainColor.withOpacity(0.5),
                        spreadRadius: 1.0,
                        blurRadius: 1.0,
                        offset: const Offset(1, 0),
                      ),
                    ]),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Text('Status: ',
                                style: TextStyle(fontWeight: FontWeight.w600)),
                            Text('Approved',
                              //data[index]['Status'],
                              style: TextStyle(
                                  color: 
                                  //data[index]['Status'] == 'Approved'
                                      //?
                                       Colors.green
                                      // : data[index]['Status'] == 'Reject'
                                      //     ? Colors.red
                                      //     : null
                                       ),
                            ),
                          ],
                        ),
                        kSpace(),
                        Row(
                          children: [
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Date From'),
                                  Divider(thickness: 1),
                                  Text("1/2/23"),//data[index]['FromDate'].toString()),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  const Text('Date to'),
                                  const Divider(thickness: 1),
                                  Text('3/4/23')//data[index]['Todate'].toString()),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text('Leave Day'),
                                  const Divider(thickness: 1),
                                  Text("3")//data[index]['LeaveDuration']),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // leaveResposed == false
                //     ?
                     Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () {
                              // declinePopUp(context, "Decline", onClickYes: () {
                              //   sendLeaveApproval(
                              //       data[index]['id'].toString(), "Rejected");
                              //   Navigator.pop(context);
                              // });
                            },
                            child: const Text('Decline'),
                          ),
                          TextButton(
                            onPressed: () {
                              // declinePopUp(context, "Approve", onClickYes: () {
                              //   sendLeaveApproval(
                              //       data[index]['id'].toString(), "Approved");
                              //   Navigator.pop(context);
                              // });
                            },
                            child: const Text('Approve'),
                          ),
                        ],
                      )
                    //: Container()
              ],
            ),
          );
          //:Container();
        },
        separatorBuilder: (BuildContext context, int index) {
          return kSpace(height: 30.0);
        },
      ),
    );
  }
}

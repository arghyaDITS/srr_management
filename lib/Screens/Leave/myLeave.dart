import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:srr_management/Screens/Leave/applyLeave.dart';
import 'package:srr_management/components/buttons.dart';
import 'package:srr_management/components/util.dart';
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
    //getLeaveData();
  }

  getLeaveData() async {
    // print(ServiceManager.userID.toString());
    // String url = APIData.userLeave;
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
    //   _streamController.add(data['UserWiseLeavs']);
    // }
    // return 'Success';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Leave'),
        actions: [
          ArrowButton(
            onClick: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LeaveApplicationScreen()));
            },
            title: 'Apply',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // BarChartSample2(),

            // StreamBuilder(
            //     stream: _streamController.stream,
            //     builder: (context, snapshot) {
            //       if (snapshot.hasData) {
            //         var data = snapshot.data;
            //         return
                     ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 10,//data.length,
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
                                        child: const Text(
                                         'status',// data[index]['Status'],
                                          style: TextStyle(
                                           // color: 
                                            // data[index]['Status'] ==
                                            //         'Approved'
                                            //     ? Colors.green
                                            //     : data[index]['Status'] ==
                                            //             'Reject'
                                            //         ? Colors.red
                                            //         : data[index]['Status'] ==
                                            //                 'Pending'
                                            //             ? Colors.orange
                                            //             : null,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 2),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        color: kMainColor.withOpacity(0.2),
                                      ),
                                      child: const Text('LeaveType')//data[index]['LeaveType']),
                                    ),
                                  ],
                                ),
                                kSpace(),
                                const Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Date From'),
                                          Divider(thickness: 1),
                                          Text("1/2/23")//data[index]['FromDate']
                                              //.toString()),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text('Date to'),
                                          Divider(thickness: 1),
                                          Text(
                                             "1/2/23")// data[index]['Todate'].toString()),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text('Duaration'),
                                          Divider(thickness: 1),
                                          Text("2")//data[index]['LeaveDuration']),
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
                    ),
                //   }
                //   return LoadingIcon();
                // }),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}

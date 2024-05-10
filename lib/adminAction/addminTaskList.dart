import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:srr_management/Screens/Leave/component/approvalPopUp.dart';
import 'package:srr_management/Screens/task/createTask.dart';
import 'package:srr_management/Screens/task/editTask.dart';
import 'package:srr_management/components/util.dart';
import 'package:srr_management/services/apiEndpoint.dart';
import 'package:srr_management/services/serViceManager.dart';
import 'package:srr_management/theme/colors.dart';
import 'package:srr_management/theme/style.dart';
import 'package:intl/intl.dart';

class AdminTaskList extends StatefulWidget {
  const AdminTaskList({Key? key}) : super(key: key);

  @override
  State<AdminTaskList> createState() => _AdminTaskListState();
}

class _AdminTaskListState extends State<AdminTaskList>
    with SingleTickerProviderStateMixin {
  final StreamController _streamController = StreamController();
  bool isLoading = false;
  bool leaveResposed = false;
  late TabController controller;

  String _selectedCategory = 'a';
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllTaskData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _streamController.close();
  }

  getAllTaskData() async {
    isLoading = true;
    String url = APIData.getAllTaskForAdmin;
    print(url);

    var res = await http.post(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${ServiceManager.tokenID}',
    }, body: {});
    print(res.statusCode);
    if (res.statusCode == 200) {
      print(res.body);

      var data = jsonDecode(res.body);

      _streamController.add(data['task']);
    }
    isLoading = false;
    return 'Success';
  }

  deleteTask(id) async {
    String url = APIData.deleteTaskByAdmin;
    print(url);

    var res = await http.post(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${ServiceManager.tokenID}',
    }, body: {
      'id': id.toString()
    });
    print(res.statusCode);
    if (res.statusCode == 200) {
      print(res.body);

      var data = jsonDecode(res.body);
      
        getAllTaskData();
    }
    return 'Success';
  }

  //----------------
  void _onCategoryChanged(String? value) async {
    // _streamController.close();
    setState(() {
      _selectedCategory = value!;
      // Simulate loading data
      _isLoading = true;
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });
      });
    });
    // await getAllTaskData(_selectedCategory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Total TaskList'),
      ),
      body: StreamBuilder(
          stream: _streamController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var snapdata = snapshot.data;
              //var items = snapshot.data;
              List data = [];
              for (var item in snapdata) {
                if (item['category_id'] == _selectedCategory) {
                  data.add(item);
                }
              }
              return Container(
                decoration: kBackgroundDesign(context),
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: isLoading == false
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: const Color.fromARGB(255, 202, 158, 223),
                              ),
                              child: DropdownButton<String>(
                                value: _selectedCategory,
                                style: const TextStyle(color: Colors.black),
                                underline: Container(
                                  height: 2,
                                  color: Colors.transparent,
                                ),
                                onChanged: _onCategoryChanged,
                                items: <String>['a', 'b', 'c', 'd']
                                    .map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      'Select category: $value',
                                      style: kHeaderStyle(
                                          color: const Color.fromARGB(
                                              255, 4, 55, 97)),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            kDivider(),
                            const SizedBox(height: 20),
                            _isLoading
                                ? const CircularProgressIndicator() // Loading icon
                                : ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: data.length,
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return const SizedBox(height: 15);
                                    },
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 5.0),
                                        child: Container(
                                          padding: const EdgeInsets.all(10.0),
                                          decoration:
                                              roundedContainerDesign(context),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                      child: Container(
                                                          child: Text(
                                                              'Title: ${data[index]['title']}',
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)))),
                                                  Row(
                                                    children: [
                                                      IconButton(
                                                          onPressed: () {
                                                            declinePopUp(
                                                                context,
                                                                "Delete",
                                                                onClickYes: () {
                                                              //--
                                                              deleteTask(
                                                                  data[index]
                                                                      ['id']);

                                                              Navigator.pop(
                                                                  context);
                                                            });
                                                          },
                                                          icon: Icon(
                                                              Icons.delete)),
                                                      IconButton(
                                                          onPressed: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            CreateTaskScreen(
                                                                              taskId: data[index]['id'],
                                                                            )));
                                                          },
                                                          icon:
                                                              Icon(Icons.edit)),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10.0,
                                                          vertical: 2),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                        color: kMainColor
                                                            .withOpacity(0.2),
                                                      ),
                                                      child: Text(
                                                          'Description:  ${data[index]['description']}'),
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
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text(
                                                            'Start Date'),
                                                        const Divider(
                                                            thickness: 1),
                                                        Text(DateFormat(
                                                                'yyyy-MM-dd')
                                                            .format(DateTime
                                                                .parse(data[
                                                                        index][
                                                                    'start_date']))
                                                            .toString()),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      children: [
                                                        const Text('Date to'),
                                                        const Divider(
                                                            thickness: 1),
                                                        Text(DateFormat(
                                                                'yyyy-MM-dd')
                                                            .format(DateTime
                                                                .parse(data[
                                                                        index][
                                                                    'end_date']))
                                                            .toString()),
                                                      ],
                                                    ),
                                                  ),

                                                  // Expanded(
                                                  //   child: Column(
                                                  //     crossAxisAlignment:
                                                  //         CrossAxisAlignment.end,
                                                  //     children: [
                                                  //       const Text('Duaration'),
                                                  //       const Divider(thickness: 1),
                                                  //       Text(data[index]['LeaveDuration']),
                                                  //     ],
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Priority: ",
                                                    style: kBoldStyle(),
                                                  ),
                                                  Container(
                                                      padding: EdgeInsets.all(
                                                          4),
                                                      color: data[index][
                                                                  'priority'] ==
                                                              'high'
                                                          ? Color.fromARGB(255,
                                                              240, 134, 126)
                                                          : data[index][
                                                                      'priority'] ==
                                                                  'low'
                                                              ? const Color
                                                                  .fromARGB(255,
                                                                  109, 207, 112)
                                                              : Color.fromARGB(
                                                                  255,
                                                                  190,
                                                                  181,
                                                                  96),
                                                      child: Text(
                                                        data[index]['priority'],
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ))
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Status: ",
                                                    style: kBoldStyle(),
                                                  ),
                                                  Text(
                                                    data[index]['status'],
                                                    style: k14Text(),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                          ],
                        )
                      : Center(
                          child: LoadingIcon(),
                        ),
                ),
              );
            }
            return Container(child: const LoadingIcon());
          }),
    );
  }
}

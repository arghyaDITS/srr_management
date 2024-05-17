import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:srr_management/Screens/Leave/component/approvalPopUp.dart';
import 'package:srr_management/Screens/task/createTask.dart';
import 'package:srr_management/Screens/task/editTask.dart';
import 'package:srr_management/Screens/task/model/userModel.dart';
import 'package:srr_management/components/util.dart';
import 'package:srr_management/services/apiEndpoint.dart';
import 'package:srr_management/services/serViceManager.dart';
import 'package:srr_management/theme/colors.dart';
import 'package:srr_management/theme/style.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
  double _rating = 0.0;
  TextEditingController _reviewController = TextEditingController();

  String _selectedCategory = 'Logistic';
  bool _isLoading = false;
  final List<String> _userList = [];
  final List<int> _userIdList = [];
  List assignedUserId = [];
  List<Users> selectedUsers = [];
  List assignedUserIdList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserList();
    getAllTaskData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _streamController.close();
  }

  getUserList() async {
    setState(() {
      isLoading = true;
    });
    String url = APIData.getUserList;
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
      for (var user in data) {
        _userList.add(user['name']);
        _userIdList.add(user['id']);
      }

      setState(() {
        isLoading = false;
      });

      //   _streamController.add(data['task']);
    }
    return 'Success';
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

  void _showReviewBottomSheet(BuildContext context, taskId, userId) {
    double _rating = 0.0;
    TextEditingController _reviewController = TextEditingController();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Add Review',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.0),
              RatingBar.builder(
                initialRating: _rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 40.0,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  _rating = rating;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _reviewController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Write your review here...',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Handle submission of rating and review
                  print('Rating: $_rating');
                  print('Review: ${_reviewController.text}');
                  sendReview(
                      taskId: taskId,
                      userId: userId,
                      rating: _rating,
                      review: _reviewController.text);
                  // Here you can implement logic to submit the rating and review
                  Navigator.pop(context); // Close the bottom sheet
                },
                child: Text('Submit'),
              ),
            ],
          ),
        );
      },
    );
  }

  sendReview({taskId, userId, rating, review}) async {
    String url = APIData.reviewTaskbyAdmin;
    print(url);

    var res = await http.post(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${ServiceManager.tokenID}',
    }, body: {
      'task_id': taskId.toString(),
      'user_id': jsonEncode(userId),
      'rating': rating.toString(),
      'review': review,
    });
    print(res.statusCode);
    if (res.statusCode == 200) {
      print(res.body);

      var data = jsonDecode(res.body);

      // getAllTaskData();
    }
    return 'Success';
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
                            Text(
                              "Select Category:",
                              style: kBoldStyle(),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 10.0),
                              child: Container(
                                height: 55,
                                width: MediaQuery.of(context).size.width,
                                // decoration: dropTextFieldDesign(),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                      width: 1.5, color: Colors.grey),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: ButtonTheme(
                                    alignedDropdown: true,
                                    child: DropdownButton(
                                      borderRadius: BorderRadius.circular(10.0),
                                      value: _selectedCategory != ''
                                          ? _selectedCategory
                                          : null,
                                      hint: Text('State'),
                                      items: <String>[
                                        'Logistic',
                                        'Office',
                                        'Admin',
                                        'Tender'
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value,style:kHeaderStyle(),),
                                        );
                                      }).toList(),
                                      onChanged:_onCategoryChanged
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Container(
                            //   width: MediaQuery.of(context).size.width,
                            //   padding: const EdgeInsets.all(6.0),
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(15.0),
                            //     color: const Color.fromARGB(255, 202, 158, 223),
                            //     boxShadow: [
                            //       BoxShadow(
                            //         color: Colors.black.withOpacity(0.1),
                            //         blurRadius: 8,
                            //         offset: Offset(0, 4),
                            //       ),
                            //     ],
                            //   ),
                            //   child: Center(
                            //     child: DropdownButton<String>(
                            //       value: _selectedCategory,
                            //       style: const TextStyle(color: Colors.black),
                            //       underline: Container(
                            //         height: 2,
                            //         color: Colors.transparent,
                            //       ),
                            //       onChanged: _onCategoryChanged,
                            //       items: <String>[
                            //         'Logistic',
                            //         'Office',
                            //         'Admin',
                            //         'Tender'
                            //       ].map((String value) {
                            //         return DropdownMenuItem<String>(
                            //           value: value,
                            //           child: Text(
                            //             '$value',
                            //             style: kHeaderStyle(
                            //                 color: const Color.fromARGB(
                            //                     255, 4, 55, 97)),
                            //           ),
                            //         );
                            //       }).toList(),
                            //     ),
                            //   ),
                            // ),
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
                                      //--------------------------------------------------------------Assigned user
                                      // assignedUserIdList = data[index]
                                      //         ['user_ids']
                                      //     .map((id) => int.parse(id))
                                      //     .toSet()
                                      //     .toList();
                                      // List<int> uniqueUserIdList = [];
                                      // for (int userId in assignedUserIdList) {
                                      //   if (!uniqueUserIdList
                                      //       .contains(userId)) {
                                      //     uniqueUserIdList.add(userId);
                                      //   }
                                      // }
                                      // for (int userId in uniqueUserIdList) {
                                      //   int index = _userIdList.indexOf(userId);
                                      //   if (index != -1) {
                                      //     selectedUsers.add(Users(
                                      //         name: _userList[index],
                                      //         id: userId));
                                      //   }
                                      // }

                                      //--------------------------------------------------------------Assigned user
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
                                              //  Text(selectedUsers[0].name),
                                              // for (var index = 0;
                                              //     index < selectedUsers.length;
                                              //     index++)
                                              //   selectedUsers.isNotEmpty
                                              //       ? Text(
                                              //           "id::${selectedUsers[index].id}")
                                              //       : Container(),

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
                                                  data[index]['status'] !=
                                                          'Completed'
                                                      ? Row(
                                                          children: [
                                                            IconButton(
                                                                onPressed: () {
                                                                  declinePopUp(
                                                                      context,
                                                                      "Delete",
                                                                      onClickYes:
                                                                          () {
                                                                    //--
                                                                    deleteTask(data[
                                                                            index]
                                                                        ['id']);

                                                                    Navigator.pop(
                                                                        context);
                                                                  });
                                                                },
                                                                icon: const Icon(
                                                                    Icons
                                                                        .delete)),
                                                            IconButton(
                                                                onPressed: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) => CreateTaskScreen(
                                                                                taskId: data[index]['id'],
                                                                              )));
                                                                },
                                                                icon: const Icon(
                                                                    Icons
                                                                        .edit)),
                                                          ],
                                                        )
                                                      : Container()
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
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4),
                                                      color: data[index]
                                                                  [
                                                                  'priority'] ==
                                                              'high'
                                                          ? const Color.fromARGB(
                                                              255,
                                                              240,
                                                              134,
                                                              126)
                                                          : data[index]['priority'] ==
                                                                  'low'
                                                              ? const Color
                                                                  .fromARGB(255,
                                                                  109, 207, 112)
                                                              : const Color
                                                                  .fromARGB(255,
                                                                  190, 181, 96),
                                                      child: Text(
                                                        data[index]['priority'],
                                                        style: const TextStyle(
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
                                              ),
                                              // Row(
                                              //   children: [
                                              //     Text(
                                              //       "User IDs: ",
                                              //       style: kBoldStyle(),
                                              //     ),
                                              //     Text(
                                              //       data[index]['user_ids']
                                              //           .join(", "),
                                              //       style: k14Text(),
                                              //     )
                                              //   ],
                                              // ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Assigned members: ",
                                                    style: kBoldStyle(),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      data[index]['user_name']
                                                          .join(", "),
                                                      style: k14Text(),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  data[index]['status'] ==
                                                          'Completed'
                                                      ? ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                Color.fromARGB(
                                                                    255,
                                                                    230,
                                                                    191,
                                                                    255),
                                                            foregroundColor:
                                                                const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    1,
                                                                    35,
                                                                    62), // Change this to the color you desire
                                                          ),
                                                          onPressed: () {
                                                            print(data[index]
                                                                ['user_ids']);
                                                            _showReviewBottomSheet(
                                                                context,
                                                                data[index]
                                                                    ['id'],
                                                                data[index][
                                                                    'user_ids']);
                                                          },
                                                          child: Text("Review"))
                                                      : Container(),
                                                ],
                                              )
                                              // data[index]['status'] ==
                                              //         'Completed'
                                              //     ? RatingBar.builder(
                                              //         initialRating: _rating,
                                              //         minRating: 1,
                                              //         direction:
                                              //             Axis.horizontal,
                                              //         allowHalfRating: true,
                                              //         itemCount: 5,
                                              //         itemSize: 40.0,
                                              //         itemPadding:
                                              //             const EdgeInsets
                                              //                 .symmetric(
                                              //                 horizontal: 4.0),
                                              //         itemBuilder:
                                              //             (context, _) =>
                                              //                 const Icon(
                                              //           Icons.star,
                                              //           color: Colors.amber,
                                              //         ),
                                              //         onRatingUpdate: (rating) {
                                              //           setState(() {
                                              //             _rating = rating;
                                              //             print(_rating);
                                              //           });
                                              //         },
                                              //       )
                                              //     : Container(),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                          ],
                        )
                      : const Center(
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

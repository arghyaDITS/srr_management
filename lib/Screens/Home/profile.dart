import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:srr_management/Screens/Auth/login.dart';
import 'package:srr_management/Screens/Leave/myLeave.dart';
import 'package:srr_management/Screens/profile/aboutUs.dart';
import 'package:srr_management/Screens/profile/editProfile.dart';
import 'package:srr_management/Screens/profile/leavdeReport.dart';
import 'package:srr_management/Screens/profile/myDocument.dart';
import 'package:srr_management/Screens/profile/salaryStateMent.dart';
import 'package:srr_management/Screens/profile/termsAndService.dart';
import 'package:srr_management/components/buttons.dart';
import 'package:srr_management/services/apiEndpoint.dart';
import 'package:srr_management/services/serViceManager.dart';
import 'package:srr_management/theme/colors.dart';
import 'package:srr_management/theme/style.dart';
import 'package:http/http.dart' as http;

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();

  // TextEditingController employeeID = TextEditingController();
  TextEditingController destination = TextEditingController();
  TextEditingController specialist = TextEditingController();
  // TextEditingController lastName = TextEditingController();
  TextEditingController fatherName = TextEditingController();
  TextEditingController motherName = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController joiningDate = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController whatsapp = TextEditingController();
  TextEditingController emergencyNumber = TextEditingController();
  TextEditingController presentAddress = TextEditingController();
  TextEditingController permanentAddress = TextEditingController();
  TextEditingController qualification = TextEditingController();
  TextEditingController experience = TextEditingController();
  TextEditingController specialization = TextEditingController();
  TextEditingController note = TextEditingController();
  TextEditingController pan = TextEditingController();
  TextEditingController nationalID = TextEditingController();
  TextEditingController localID = TextEditingController();
  TextEditingController password = TextEditingController();

  String profileURL = '';
  String roleValue = '';
  String departmentValue = '';
  String genderValue = '';
  String maritalValue = '';
  String bloodValue = '';
  bool isAdmin = false;
  bool uploading = false;

  @override
  void initState() {
    super.initState();
    // ServiceManager().getNotificationTime();
   ServiceManager().getUserData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.minScrollExtent) {
        yourFunctionToExecuteOnScroll();
      }
    });
  }


  void yourFunctionToExecuteOnScroll() {
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Future<String?> logoutBuilder(BuildContext context,
      {required Function() onClickYes}) {
    // final FirebaseAuth _auth = FirebaseAuth.instance;
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        title: Text('Logout', style: kHeaderStyle()),
        content: Text('Are you sure you want to logout?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: onClickYes,
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBackgroundDesign(context),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          controller: _scrollController,
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(height: kToolbarHeight),
              Column(
                children: [
                  Stack(
                    children: [
                      Column(
                        children: [
                          SizedBox(height: 120),
                          Container(
                            padding: EdgeInsets.all(15),
                            decoration: blurCurveDecor(context),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(),
                                Text("${ServiceManager.userName}", style: kHeaderStyle()),
                                Text("designation"),
                              ],
                            ),
                          ),
                        ],
                      ),
                      CircleAvatar(
                          radius: 70,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor !=
                                      Colors.black
                                  ? kMainColor
                                  : kDarkColor,
                          child: CircleAvatar(
                            radius: 65,
                            backgroundImage:
                                AssetImage('images/img_blank_profile.png'),
                          )),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Container(
                decoration: blurCurveDecor(context),
                child: Column(
                  children: [
                    profileButton(Icons.edit_outlined, 'Edit Profile', () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfile()));
                    }),
                  ],
                ),
              ),
              kSpace(),
              Container(
                decoration: blurCurveDecor(context),
                child: Column(
                  children: [
                    profileButton(Icons.flight_takeoff_outlined, 'My Leaves',
                        () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyLeave()));
                    }),
                  ],
                ),
              ),
              Container(
                decoration: blurCurveDecor(context),
                child: Column(
                  children: [
                    profileButton(
                        Icons.currency_rupee_outlined, 'Salary Statement', () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SalaryStatement()));
                    }),
                    profileButton(Icons.receipt_long_outlined, 'Leave Report',
                        () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LeaveReportScreen()));
                    }),
                    // profileButton(Icons.receipt_long_outlined, 'Notification', (){
                    //   Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationPage()));
                    // }),
                  ],
                ),
              ),
              kSpace(),
              Container(
                decoration: blurCurveDecor(context),
                child: Column(
                  children: [
                    profileButton(Icons.call_outlined, 'Contact Us', () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AboutUsScreen()));
                    }),
                    profileButton(Icons.info_outlined, 'About Us', () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AboutUsScreen()));
                    }),
                    profileButton(
                        Icons.receipt_long_outlined, 'Terms and Condition', () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TermsAndConditionsScreen()));
                    }),
                    profileButton(Icons.receipt_long_outlined, 'Privacy Policy',
                        () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TermsAndConditionsScreen()));
                    }),
                  ],
                ),
              ),
              kSpace(),
              KButton(
                title: 'Logout',
                onClick: () {
                  logoutBuilder(context, onClickYes: () {
                    try {
                      Navigator.pop(context);
                      setState(() {
                        isLoading = true;
                      });
                      ServiceManager().removeAll();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                          (route) => false);
                    } catch (e) {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

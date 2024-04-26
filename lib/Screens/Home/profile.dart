
import 'package:flutter/material.dart';
import 'package:srr_management/Screens/Leave/myLeave.dart';
import 'package:srr_management/Screens/profile/aboutUs.dart';
import 'package:srr_management/Screens/profile/editProfile.dart';
import 'package:srr_management/Screens/profile/leavdeReport.dart';
import 'package:srr_management/Screens/profile/myDocument.dart';
import 'package:srr_management/Screens/profile/salaryStateMent.dart';
import 'package:srr_management/Screens/profile/termsAndService.dart';
import 'package:srr_management/components/buttons.dart';
import 'package:srr_management/theme/colors.dart';
import 'package:srr_management/theme/style.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // ServiceManager().getNotificationTime();

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
                                Text("name", style: kHeaderStyle()),
                                Text("designation"),
                              ],
                            ),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: 70,
                        backgroundColor:Theme.of(context).scaffoldBackgroundColor != Colors.black ?
                        kMainColor : kDarkColor,
                        child:
                       
                        CircleAvatar(
                          radius: 65,
                          backgroundImage: AssetImage('images/img_blank_profile.png'),
                        ) 
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Container(
                decoration: blurCurveDecor(context),
                child: Column(
                  children: [
                    profileButton(Icons.edit_outlined, 'Edit Profile', (){
                     Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile()));
                    }),
                  
                  ],
                ),
              ),
              kSpace(),
               Container(
                decoration: blurCurveDecor(context),
                child: Column(
                  children: [ 
                    profileButton(Icons.flight_takeoff_outlined, 'My Leaves', (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const MyLeave()));
                    }),
                  ],
                ),
              ),
              Container(
                decoration: blurCurveDecor(context),
                child: Column(
                  children: [
                    profileButton(Icons.currency_rupee_outlined, 'Salary Statement', (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SalaryStatement()));
                    }),
                    profileButton(Icons.receipt_long_outlined, 'Leave Report', (){
                     Navigator.push(context, MaterialPageRoute(builder: (context) => LeaveReportScreen()));
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
                    profileButton(Icons.call_outlined, 'Contact Us', (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUsScreen()));
                    }),
                    profileButton(Icons.info_outlined, 'About Us', (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUsScreen()));
                    }),
                    profileButton(Icons.receipt_long_outlined, 'Terms and Condition', (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TermsAndConditionsScreen()));
                    }),
                    profileButton(Icons.receipt_long_outlined, 'Privacy Policy', (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TermsAndConditionsScreen()));
                    }),
                  ],
                ),
              ),
              kSpace(),
              KButton(
                title: 'Logout',
                onClick: (){
                  // logoutBuilder(context, onClickYes: (){
                  //   try {
                  //     Navigator.pop(context);
                  //     setState(() {
                  //       isLoading = true;
                  //     });
                  //     ServiceManager().removeAll();
                  //     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                  //         builder: (context) => Login()), (route) => false);
                  //   } catch (e){
                  //     setState(() {
                  //       isLoading = false;
                  //     });
                  //   }
                  // });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:srr_management/Screens/Auth/login.dart';
import 'package:srr_management/theme/style.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // ServiceManager().getUserID();
    // ServiceManager().getTokenID();
    // LocationService().fetchLocation();
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      //if(ServiceManager.userID != ''){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
            builder: (context) => Login()), (route) => false);
      // } else {
      //   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
      //       builder: (context) => Login()), (route) => false);
      // }
    });
  }

  @override
  void dispose() {
    super.dispose();
    if(_timer!.isActive) _timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBackgroundDesign(context),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(child: Image.asset('images/logo.jpg', height: 200)),
      ),
    );
  }
}

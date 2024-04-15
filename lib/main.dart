import 'package:flutter/material.dart';
import 'package:srr_management/Screens/splashscreen.dart';
import 'package:srr_management/theme/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carpool',
      debugShowCheckedModeBanner: false,
      theme: Constants.lightTheme,
      darkTheme: Constants.darkTheme,
      themeMode: ThemeMode.system,
      home: SplashScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:srr_management/Screens/Home/dashboard.dart';
import 'package:srr_management/Screens/Home/profile.dart';
import 'package:srr_management/Screens/task/totalTaskList.dart';
import 'package:srr_management/components/util.dart';
import 'package:srr_management/services/serViceManager.dart';
import 'package:srr_management/theme/colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  String message = '';
  bool isLoading = false;

  static final List<Widget> _widgetOptions = <Widget>[
    const DashboardView(),
    const TotalTaskList(
      status: "Total",
    ),
    const ProfileView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }
   getData() async {
    setState(() {
      isLoading = true;
    });
     ServiceManager().getUserData();
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      isLoading = false;
    });
  }

  Future<void> checkDeviceType() async {
    String platform = '';
    try {
      platform = await const MethodChannel('samples.flutter.dev/device_info')
          .invokeMethod('getPlatform');
    } on PlatformException catch (e) {
      print("Failed to get platform: '${e.message}'.");
    }

    setState(() {
      if (platform == 'tv') {
        message = 'Welcome to TV';
      } else {
        message = 'Welcome to App';
      }
    });
  }

  Future<bool> _onBackPressed() async {
    if (_selectedIndex != 0) {
      setState(() {
        _selectedIndex = 0;
      });
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: _selectedIndex == 0
            ? AppBar(
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.blueGrey,
                        Colors.white
                      ], // Define your gradient colors
                    ),
                  ),
                ),
                leading: GestureDetector(
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
                  },
                ),
                centerTitle: true,
                title: Image.asset('images/srr_logo.png', height: 55),
              )
            : null,
        body:isLoading==true?Center(child: LoadingIcon()): Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.cottage_outlined),
              activeIcon: Icon(Icons.cottage),
              label: 'Home',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.home_repair_service_outlined),
            //   activeIcon: Icon(Icons.home_repair_service),
            //   label: 'Category',
            // ),

            BottomNavigationBarItem(
              icon: Icon(Icons.groups_outlined),
              activeIcon: Icon(Icons.groups),
              label: 'Task',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: kMainColor,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

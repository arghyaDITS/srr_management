import 'package:flutter/material.dart';
import 'package:srr_management/Screens/Home/dashboard.dart';
import 'package:srr_management/Screens/Home/profile.dart';
import 'package:srr_management/Screens/Home/taskView.dart';
import 'package:srr_management/Screens/task/totalTaskList.dart';
import 'package:srr_management/theme/colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

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
                backgroundColor: k2MainColor,
                leading: GestureDetector(
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
                  },
                  // child: const Padding(
                  //     padding: EdgeInsets.all(10.0),
                  //     child: CircleAvatar(
                  //       radius: 10.0,
                  //       backgroundImage:
                  //           AssetImage('images/img_blank_profile.png'),
                  //     )),
                ),
                centerTitle: true,
                title: CircleAvatar(
                  child: Image.asset('images/logo.jpg', height: 55),
                  radius: 30,
                ),
                // title: Text('Astha Saloon'),
                // actions: [
                //   // if(ServiceManager.isAdmin != false)
                //   IconButton(
                //     onPressed: (){
                //       // Navigator.push(context, MaterialPageRoute(
                //       //     builder: (context) => AppointmentCalender()));
                //     },
                //     icon: const Icon(Icons.calendar_month_outlined),
                //   ),
                //   IconButton(
                //     onPressed: (){
                //    //   LocationService().fetchLocation();
                //     },
                //     icon: const Icon(Icons.refresh),
                //   ),
                // ],
              )
            : null,
        body: Center(
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

import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:srr_management/Screens/Leave/applyLeave.dart';
import 'package:srr_management/Screens/Leave/leaveManagement.dart';
import 'package:srr_management/Screens/Leave/myLeave.dart';
import 'package:srr_management/Screens/notes/notes.dart';
import 'package:srr_management/Screens/task/archivedTaskList.dart';
import 'package:srr_management/Screens/task/createTask.dart';
import 'package:srr_management/Screens/task/failedTaskList.dart';
import 'package:srr_management/Screens/task/inProgressTaskListScreen.dart';
import 'package:srr_management/Screens/task/issuedTaskScreen.dart';
import 'package:srr_management/Screens/task/planningTask.dart';
import 'package:srr_management/Screens/task/reviewscreen.dart';
import 'package:srr_management/Screens/task/taskList.dart';
import 'package:srr_management/Screens/task/totalTaskList.dart';
import 'package:srr_management/adminAction/addminTaskList.dart';
import 'package:srr_management/adminAction/testfile.dart';
import 'package:srr_management/components/util.dart';
import 'package:srr_management/services/serViceManager.dart';
import 'package:srr_management/theme/style.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  String user = "Tony";
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    ServiceManager().getUserData();
    setState(() {
      isLoading = false;
    });
  }

  customContainer({height, width, color, iconData, text2, onPress, fontsize}) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
          decoration: BoxDecoration(
            //shape: BoxShape.circle,
            borderRadius: BorderRadius.circular(25),
            color: Colors.blue,
          ),
          padding: const EdgeInsets.all(8),
          width: width,
          height: height,
          // Color of the square container
          child: Center(
            child: Container(
              width: 150, // Adjust the size as needed
              height: 150, // Adjust the size as needed
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white, // Color of the circle
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    iconData,
                    color: Color.fromARGB(255, 81, 47, 129),
                  ),
                  // Text(
                  //   //textAlign: TextAlign.center,
                  //   text1,
                  //   style: TextStyle(
                  //     fontSize: fontsize ?? 20,
                  //     fontWeight: FontWeight.bold,
                  //     color: Colors.black, // Color of the text
                  //   ),
                  // ),
                  Text(
                    //textAlign: TextAlign.center,
                    text2,
                    style: TextStyle(
                      fontSize: fontsize ?? 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Color of the text
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  smallContainer(
      {text,
      color,
      quantity,
      height,
      width,
      fontsize,
      isIcon,
      iconData,
      onPress}) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: const EdgeInsets.all(5),
        width: width ?? 110,
        height: height ?? 110,
        decoration: BoxDecoration(
          //shape: BoxShape.circle,
          borderRadius: BorderRadius.circular(25),
          color: color, // Color of the circle
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              isIcon == true
                  ? Icon(iconData)
                  : Text(
                      quantity,
                      style: TextStyle(
                        fontSize: fontsize ?? 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Color of the text
                      ),
                    ),
              Text(
                text,
                style: TextStyle(
                  fontSize: fontsize ?? 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Color of the text
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBackgroundDesign(context),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: isLoading == false
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GradientText(
                            "Welcome\n ${ServiceManager.userName.split(" ")[0]}! ",
                            style: const TextStyle(
                                fontSize: 28.0, fontWeight: FontWeight.w700),
                            colors: const [
                              Colors.purple,
                              Colors.red,
                              Color.fromARGB(255, 13, 152, 18),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        customContainer(
                            height: 210.0,
                            width: 180.0,
                            iconData: Icons.calendar_today,
                            text2: "Todays work!",
                            onPress: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TodaysTaskListScreen()));
                            }),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            customContainer(
                                height: 100.0,
                                width: 130.0,
                                iconData: Icons.task,
                                text2: "In Progress",
                                fontsize: 14.0,
                                onPress: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const TotalTaskList(
                                                status: "In Progress",
                                              )));
                                }),
                            const SizedBox(
                              height: 10,
                            ),
                            customContainer(
                                height: 100.0,
                                width: 130.0,
                                iconData: Icons.task_alt_sharp,
                                text2: "Completed",
                                fontsize: 14.0,
                                onPress: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const TotalTaskList(
                                                status: "Completed",
                                              )));
                                }),
                          ],
                        )
                      ],
                    ),
                    ServiceManager.roleAs == 'user'
                        ? SizedBox(
                            height: 30,
                          )
                        : Container(),
                    ServiceManager.roleAs == 'user'
                        ? Container()
                        : const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 10),
                                child: Text(
                                  "Admin's Actions:-",
                                  style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                    ServiceManager.roleAs == 'user'
                        ? Container()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              smallContainer(
                                  color:
                                      const Color.fromARGB(255, 143, 177, 170),
                                  text: "Add task",
                                  quantity: '1',
                                  height: 80.0,
                                  width: 80.0,
                                  fontsize: 12.0,
                                  isIcon: true,
                                  onPress: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CreateTaskScreen()));
                                  },
                                  iconData: Icons.add_task),
                              smallContainer(
                                  color:
                                      const Color.fromARGB(255, 141, 184, 175),
                                  text: "Notes",
                                  quantity: '1',
                                  height: 80.0,
                                  width: 80.0,
                                  fontsize: 12.0,
                                  isIcon: true,
                                  onPress: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddNoteScreen()));
                                  },
                                  iconData: Icons.notes_outlined),
                              smallContainer(
                                  color:
                                      const Color.fromARGB(255, 116, 156, 148),
                                  text: "Total Task",
                                  quantity: '1',
                                  height: 80.0,
                                  width: 80.0,
                                  fontsize: 12.0,
                                  isIcon: true,
                                  iconData: Icons.leave_bags_at_home,
                                  onPress: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const AdminTaskList()));
                                  }),
                              smallContainer(
                                  color:
                                      const Color.fromARGB(255, 116, 156, 148),
                                  text: "Leaves",
                                  quantity: '1',
                                  height: 80.0,
                                  width: 80.0,
                                  fontsize: 12.0,
                                  isIcon: true,
                                  iconData: Icons.leave_bags_at_home,
                                  onPress: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LeaveManagement()));
                                  }),
                            ],
                          ),
                    const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 15.0),
                          child: Text(
                            "Filter Task by",
                            style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        smallContainer(
                            color: const Color.fromARGB(255, 129, 80, 207),
                            text: "Apply Leave",
                            isIcon: true,
                            iconData: Icons.leave_bags_at_home,
                            onPress: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          LeaveApplicationScreen()));
                            },
                            quantity: '1'),
                        smallContainer(
                            color: Color.fromARGB(255, 99, 137, 221),
                            text: "Review",
                            isIcon: true,
                            iconData: Icons.reviews,
                            onPress: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ReviewScreen()));
                            },
                            quantity: '3'),
                        smallContainer(
                            color: const Color.fromARGB(255, 103, 52, 185),
                            text: "Archived",
                            isIcon: true,
                            iconData: Icons.archive_rounded,
                            onPress: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ArchivedTaskList()));
                            },
                            quantity: '0'),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        smallContainer(
                            color: const Color.fromARGB(255, 192, 63, 23),
                            text: "Failed Task",
                            isIcon: true,
                            iconData: Icons.sms_failed,
                            onPress: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const FailedTaskList(
                                            status: "In Progress",
                                          )
                                      //InProgressTaskListScreen()
                                      ));
                            },
                            quantity: '0'),
                        smallContainer(
                            color: Colors.deepOrangeAccent,
                            text: "My Issues",
                            isIcon: true,
                            iconData: Icons.sync_problem_rounded,
                            onPress: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => IssuedTaskScreen(
                                            isAdmin: false,
                                          )));
                            },
                            quantity: '1'),
                        ServiceManager.roleAs == 'user'
                            ? smallContainer(
                                color: const Color.fromARGB(255, 216, 124, 95),
                                text: "Notes",
                                isIcon: true,
                                iconData: Icons.flight_takeoff_outlined,
                                onPress: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                               AddNoteScreen()));
                                },
                                quantity: '3')
                            : smallContainer(
                                color: const Color.fromARGB(255, 216, 124, 95),
                                text: "Issues",
                                isIcon: true,
                                iconData: Icons.report_problem,
                                onPress: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              IssuedTaskScreen(
                                                isAdmin: true,
                                              )));
                                },
                                quantity: '3'),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 20)
                  ],
                ),
              )
            : Center(child: LoadingIcon()),
      ),
    );
  }
}

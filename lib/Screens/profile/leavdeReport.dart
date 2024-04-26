import 'package:flutter/material.dart';
import 'package:srr_management/theme/style.dart';

class LeaveReportScreen extends StatelessWidget {
  // Example data for demonstration
  final List<Map<String, dynamic>> leaveData = [
    {
      'month': 'January',
      'leaveType': 'Annual Leave',
      'halfDay': false,
      'duration': 2,
      'fromDate': '2024-01-05',
      'toDate': '2024-01-06',
    },
    {
      'month': 'February',
      'leaveType': 'Sick Leave',
      'halfDay': true,
      'duration': 0.5,
      'fromDate': '2024-02-12',
      'toDate': '2024-02-12',
    },
    {
      'month': 'February',
      'leaveType': 'Sick Leave',
      'halfDay': false,
      'duration': 0.5,
      'fromDate': '2024-02-12',
      'toDate': '2024-02-12',
    },
    {
      'month': 'February',
      'leaveType': 'Sick Leave',
      'halfDay': false,
      'duration': 0.5,
      'fromDate': '2024-02-12',
      'toDate': '2024-02-12',
    },
    {
      'month': 'February',
      'leaveType': 'Sick Leave',
      'halfDay': false,
      'duration': 0.5,
      'fromDate': '2024-02-12',
      'toDate': '2024-02-12',
    },
    {
      'month': 'February',
      'leaveType': 'Sick Leave',
      'halfDay': false,
      'duration': 0.5,
      'fromDate': '2024-02-12',
      'toDate': '2024-02-12',
    },
    {
      'month': 'February',
      'leaveType': 'Sick Leave',
      'halfDay': false,
      'duration': 0.5,
      'fromDate': '2024-02-12',
      'toDate': '2024-02-12',
    },
    // Add more data as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leave Report'),
      ),
      body: Container(
        decoration: kBackgroundDesign(context),
        child: ListView.builder(
          itemCount: leaveData.length,
          itemBuilder: (context, index) {
            final leave = leaveData[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              elevation: 4,
              child: ListTile(
                leading: Icon(Icons.calendar_today),
                title: Text(
                  '${leave['month']} ${leave['fromDate']} - ${leave['toDate']}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Leave Type: ${leave['leaveType']}'),
                    Text('Duration: ${leave['duration']} day${leave['duration'] > 1 ? 's' : ''}'),
                    if (leave['halfDay'])
                      Text('Half Day: Yes', style: TextStyle(color: Colors.red)),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    // Handle tile tap
                  },
                ),
                onTap: () {
                  // Handle tile tap
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
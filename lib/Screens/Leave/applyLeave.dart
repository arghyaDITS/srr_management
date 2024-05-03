import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:srr_management/components/util.dart';
import 'package:srr_management/services/apiEndpoint.dart';
import 'package:http/http.dart' as http;
import 'package:srr_management/services/serViceManager.dart';

class LeaveApplicationScreen extends StatefulWidget {

  int? leaveId;
  LeaveApplicationScreen({super.key,  this.leaveId});

  @override
  _LeaveApplicationScreenState createState() => _LeaveApplicationScreenState();
}

class _LeaveApplicationScreenState extends State<LeaveApplicationScreen> {
  String _leaveType = 'Annual Leave';
  DateTime _fromDate = DateTime.now();
  DateTime _toDate = DateTime.now();
  int _numberOfDays = 1;
  TextEditingController _leaveDescriptionController = TextEditingController();
  bool isLoading = false;

   @override
  void initState() {
    
    super.initState();

  }

  applyLeave() async {
    isLoading = true;
    String url = APIData.applyLeave;
    print(ServiceManager.userID);
    print(url.toString());
    var res = await http.post(Uri.parse(url), headers: APIData.kHeader, body: {
      'user_id': ServiceManager.userID,
      'leave_type': _leaveType,
      'total_days': _numberOfDays.toString(),
      'from_date': _fromDate.toString(),
      'to_date': _toDate.toString(),
      
     
    });
    print(res.statusCode);
    if (res.statusCode == 200) {
      toastMessage(message: 'Request Submitted');
      print(res.body);
      var data = jsonDecode(res.body);
      isLoading = false;
    }
    return 'Success';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leave Application'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _leaveDescriptionController,
              decoration: const InputDecoration(
                labelText: 'Leave Description',
              ),
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _leaveType,
              onChanged: (newValue) {
                setState(() {
                  _leaveType = newValue!;
                });
              },
              items: <String>[
                'Annual Leave',
                'Sick Leave',
                'Maternity Leave',
                'Paternity Leave',
                'Unpaid Leave',
                // Add more leave types as needed
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: const InputDecoration(
                labelText: 'Leave Type',
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: _fromDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (selectedDate != null) {
                        setState(() {
                          _fromDate = selectedDate;
                        });
                      }
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'From Date',
                      ),
                      child: Text(
                        '${_fromDate.year}-${_fromDate.month}-${_fromDate.day}',
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: _toDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (selectedDate != null) {
                        setState(() {
                          _toDate = selectedDate;
                        });
                      }
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'To Date',
                      ),
                      child: Text(
                        '${_toDate.year}-${_toDate.month}-${_toDate.day}',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _numberOfDays = int.tryParse(value) ?? 0;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Number of Days',
              ),
            ),
            const SizedBox(height: 32.0),
            Center(
              child: isLoading == false
                  ? ElevatedButton(
                      onPressed: () {
                        if (_leaveDescriptionController.text.isEmpty ||
                            _numberOfDays <= 0) {
                          // Show error message or toast indicating required fields
                          toastMessage(message: 'Please fill all fields');
                          return; // Exit function if validation fails
                        } else {
                          applyLeave();
                          Navigator.pop(context);
                        }

                        // Add logic to submit leave application
                      },
                      child: const Text('Apply'),
                    )
                  : LoadingIcon(),
            ),
          ],
        ),
      ),
    );
  }
}

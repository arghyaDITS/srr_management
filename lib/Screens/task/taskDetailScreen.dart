import 'package:flutter/material.dart';
import 'package:srr_management/components/buttons.dart';
import 'package:srr_management/theme/style.dart';

class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen({super.key});

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  String _dropdownValue = 'UnStarted';
  bool isTooltipVisible = false;
  String issue = '';

  Future<void> _showIssueDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Report Issue'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Enter issue...',
                  ),
                  onChanged: (value) {
                    issue = value;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // Save the issue and close the dialog
                _saveIssue(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _saveIssue(BuildContext context) {
    // Here you can handle saving the issue, for now let's just print it
    print('Issue: $issue');
    Navigator.of(context).pop(); // Close the dialog
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
      ),
      body: Container(
          decoration: kBackgroundDesign(context),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
              padding: const EdgeInsets.only(
                  top: 30.0, bottom: 250, left: 30, right: 30),
              child: Card(
                elevation: 4,
                margin: const EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Task ID: {widget.taskId}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Task Description:  I also customized the appearance of the dropdown items by wrapping the text inside a container and adjusting its width and alignment. You can further customize the appearance as needed',
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Handle archive button click
                            },
                            child: const Text('Archive'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Handle start button click
                            },
                            child: const Text('Start'),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Task Status:",
                            style: kHeaderStyle(),
                          ),
                          DropdownButton<String>(
                            value: _dropdownValue,
                            onChanged: (String? newValue) {
                              setState(() {
                                _dropdownValue = newValue!;
                              });
                            },
                            items: <String>[
                              'UnStarted',
                              'Completed',
                              'In Progress'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Container(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    width: 100, // Adjust the width as needed
                                    alignment: Alignment.center,
                                    child: Text(value)),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                              textScaleFactor:
                                  0.8, // Adjust the scaling factor as needed
                              overflow: TextOverflow.ellipsis,
                              "Having Issue, Raise Flag!"),
                          IconButton(
                            icon: const Icon(Icons.flag),
                            color: Colors.red,
                            onPressed: () {
                              _showIssueDialog(context);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ))),
    );
  }
}

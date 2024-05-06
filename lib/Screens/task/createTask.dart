import 'dart:convert';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:file_selector/file_selector.dart' as file_selector;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:srr_management/Screens/Home/home.dart';
import 'package:srr_management/components/util.dart';
import 'package:srr_management/services/apiEndpoint.dart';
import 'package:srr_management/services/serViceManager.dart';
import 'package:srr_management/theme/style.dart';
import 'package:http/http.dart' as http;

class CreateTaskScreen extends StatefulWidget {
  int? taskId;
  CreateTaskScreen({super.key, this.taskId});
  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  String _selectedPriority =
      'Medium'; // Ensure this matches one of the dropdown items
  String _selectedUser2 = 'Select Member';
  String _selectedUser =
      'Select Member'; // Ensure this matches one of the dropdown items
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  int? _duration;
  String category = 'a';
  bool isMoreMember = false;
  //String _filePath = '';
  bool isSelected = false;
  List<String> userList = [];
  bool isLoading = false;
  final List<String> _userList =[];

  late String _filePath; // Variable to store the path of the selected file

  Future<void> _openFileExplorer() async {
    try {
      // Open file picker to select file
      final file_selector.XFile? file = await file_selector.openFile(
        acceptedTypeGroups: [
          const file_selector.XTypeGroup(
              label: 'Documents', extensions: ['pdf', 'doc', 'docx'])
        ],
      );

      if (file != null) {
        setState(() {
          _filePath = file.path; // Update the selected file path
        });
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _filePath = ''; // Initialize file path
    print(widget.taskId);
    widget.taskId != null ? getTaskData() : null;
    getUserList();
  }

  void _calculateDuration() {
    if (_startDate != null && _endDate != null) {
      setState(() {
        _duration = _endDate!.difference(_startDate!).inDays;
      });
    }
  }
getUserList()async
{
   setState(() {
      isLoading = true;
    });
    String url = APIData.getUserList;
    print(url);

    var res = await http.get(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${ServiceManager.tokenID}',
    },);
    print(res.statusCode);
    if (res.statusCode == 200) {
      print(res.body);

      var data = jsonDecode(res.body);
      print(data.toString());
       for (var user in data) {
    _userList.add(user['name']);
  }

      setState(() {
        isLoading = false;
      });

      //   _streamController.add(data['task']);
    }
    return 'Success';

}
 
  userField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AutoCompleteTextField<String>(
          key: GlobalKey(),
          clearOnSubmit: false,
          suggestions: _userList,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Assign User',
          ),
          itemFilter: (item, query) {
            return item.toLowerCase().startsWith(query.toLowerCase());
          },
          itemSorter: (a, b) {
            return a.compareTo(b);
          },
          itemSubmitted: (item) {
            setState(() {
              _selectedUser = item;
              isSelected = true;
              isMoreMember = false;
              userList.add(item);
            });
          },
          itemBuilder: (context, item) {
            return ListTile(
              title: Text(item),
            );
          },
        ),
      ],
    );
  }

  String _calculateDifference() {
    final difference = _endDate!.difference(_startDate!);
    final days = difference.inDays;
    final hours = difference.inHours.remainder(24);
    return '$days days'; //and $hours hours';
  }

  getTaskData() async {
    setState(() {
      isLoading = true;
    });
    String url = APIData.getTaskById;
    print(url);

    var res = await http.post(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${ServiceManager.tokenID}',
    }, body: {
      'task_id': widget.taskId.toString()
    });
    print(res.statusCode);
    if (res.statusCode == 200) {
      print(res.body);

      var data = jsonDecode(res.body);
      _titleController.text = data['task']['title'];
      _descriptionController.text = data['task']['description'];
      _startDate = DateTime.parse(data['task']['start_date']);
      _endDate = DateTime.parse(data['task']['end_date']);
      _selectedPriority = data['task']['priority']=='high'?"High":data['task']['priority']=='low'?"Low":"Medium";
      category = data['task']['category_id'];

      setState(() {
        isLoading = false;
      });

      //   _streamController.add(data['task']);
    }
    return 'Success';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.taskId == null ? 'Create Task' : "Edit Task"),
      ),
      body: Container(
        decoration: kBackgroundDesign(context),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Task Title',
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Task Description',
                  ),
                ),
                const SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  value: _selectedPriority,
                  onChanged: (value) {
                    setState(() {
                      _selectedPriority = value!;
                    });
                  },
                  items: <String>['High', 'Medium', 'Low']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Priority',
                  ),
                ),
                const SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  value: category,
                  onChanged: (value) {
                    setState(() {
                      category = value!;
                    });
                  },
                  items: <String>['a', 'b', 'c', 'd']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Select Category',
                  ),
                ),
                // DropdownButtonFormField<String>(
                //   value: _selectedUser,
                //   onChanged: (value) {
                //     setState(() {
                //       _selectedUser = value!;
                //     });
                //   },
                //   items: _userList
                //       .map<DropdownMenuItem<String>>((String value) {
                //     return DropdownMenuItem<String>(
                //       value: value,
                //       child: Text(value),
                //     );
                //   }).toList(),
                //   decoration: InputDecoration(
                //     border: OutlineInputBorder(),
                //     labelText: 'Assign User',
                //   ),
                // ),
                const SizedBox(height: 16.0),
                //_________________________________________________
                DropdownButtonFormField<String>(
                  value: _selectedUser,
                  onChanged: (value) {
                    setState(() {
                      _selectedUser = value!;
                    });
                  },
                  items: <String>[
                    'Select Member',
                    'User 1',
                    'User 2',
                    'User 3',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Select Category',
                  ),
                ),
                //__________________________________________________________
                //userField(),
                const SizedBox(height: 16.0),
                isMoreMember
                    ? DropdownButtonFormField<String>(
                        value: _selectedUser2,
                        onChanged: (value) {
                          setState(() {
                            _selectedUser2 = value!;
                            //  isMoreMember=false;
                          });
                        },
                        items: <String>[
                          'Select Member',
                          'User 1',
                          'User 2',
                          'User 3',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Select Category',
                        ),
                      )
                    : Container(),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            isMoreMember = true;
                          });
                        },
                        icon: const Icon(Icons.add)),
                    const Text("Add more member")
                  ],
                ),

                const SizedBox(height: 10),
                _filePath.isNotEmpty
                    ? Text('Selected File: $_filePath')
                    : const SizedBox(),
                const Text(
                  'Start Date:',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                //const SizedBox(height: 10.0),

                GestureDetector(
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: _startDate ?? DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null && picked != _startDate) {
                      setState(() {
                        _startDate = picked;
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black, // Specify your border color here
                        width: 0.7, // Specify the width of the border
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_startDate != null
                            ? DateFormat('yyyy-MM-dd')
                                .format(DateTime.parse(_startDate!.toString()))
                                .toString()
                            : 'Select Start Date'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'End Date:',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                // const SizedBox(height: 10.0),

                GestureDetector(
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: _endDate ?? DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null && picked != _endDate) {
                      setState(() {
                        _endDate = picked;
                      });
                      _calculateDifference();
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black, // Specify your border color here
                        width: 0.7, // Specify the width of the border
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_endDate != null
                            ? DateFormat('yyyy-MM-dd')
                                .format(DateTime.parse(_endDate!.toString()))
                                .toString()
                            : 'Select End Date'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                (_startDate != null && _endDate != null)
                    ? Text(
                        'Duration: ${_calculateDifference()}',
                        style: const TextStyle(fontSize: 16),
                      )
                    : Container(),
                ElevatedButton(
                  onPressed: () {}, //_openFileExplorer,
                  child: const Text('Upload Document'),
                ),
                ElevatedButton(
                  onPressed: () {
                   widget.taskId!=null?editTask(): postTask();

                    // Handle task creation here
                    // print('Task Title: ${_titleController.text}');
                    // print('Task Description: ${_descriptionController.text}');
                    // print('Priority: $_selectedPriority');
                    // print('Assigned User: $_selectedUser');
                  },
                  child:  Text(widget.taskId!=null?'Edit Task':'Create Task'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  editTask() async {
    String url = "${APIData.upDateTask}/${widget.taskId}";
    print(url.toString());
    var res = await http.post(Uri.parse(url), headers: APIData.kHeader, body: {
      'title': _titleController.text,
      'description': _descriptionController.text,
      'start_date': _startDate.toString(),
      'end_date': _endDate.toString(),
      'user_ids': jsonEncode(['23', '89']),
      'category_id': category,
      'priority': _selectedPriority,
    });
    if (res.statusCode == 200) {
      toastMessage(message: 'Task Created');
      print(res.body);
      var data = jsonDecode(res.body);
      print(data.toString());
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Home()));
    } else {
      print(res.body);
    }
    return 'Success';
  }

  postTask() async {
    String url = APIData.createTask;
    print(url.toString());
    var res = await http.post(Uri.parse(url), headers: APIData.kHeader, body: {
      'title': _titleController.text,
      'description': _descriptionController.text,
      'start_date': _startDate.toString(),
      'end_date': _endDate.toString(),
      'user_ids': jsonEncode(['23', '89']),
      'category_id': category,
      'priority': _selectedPriority,
    });
    if (res.statusCode == 200) {
      toastMessage(message: 'Task Created');
      print(res.body);
      var data = jsonDecode(res.body);
      print(data.toString());
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Home()));
    } else {
      print(res.body);
    }
    return 'Success';
  }
}

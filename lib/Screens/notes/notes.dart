import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:srr_management/Screens/notes/noteModel.dart';
import 'package:srr_management/components/util.dart';
import 'package:srr_management/services/apiEndpoint.dart';
import 'package:srr_management/services/serViceManager.dart';
import 'package:srr_management/theme/style.dart';
import 'package:http/http.dart' as http;

class AddNoteScreen extends StatefulWidget {
  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final List<Note> notes = [];
  final TextEditingController _textController = TextEditingController();
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllNoteList();
  }

  createNote() async {
    setState(() {
      isLoading = true;
    });
    String url = APIData.postNote;
    print(ServiceManager.userID);
    print(_textController.text);
    print(url.toString());
    var res = await http.post(Uri.parse(url), headers: APIData.kHeader, body: {
      "title": "test",
      "description": _textController.text,
      "user_id": ServiceManager.userID
    });
    print(res.statusCode);
    if (res.statusCode == 200) {
      toastMessage(message: 'Note Added');
      print(res.body);
      var data = jsonDecode(res.body);
      setState(() {
        isLoading = false;
      });
    }
    return 'Success';
  }

  getAllNoteList() async {
    String url = APIData.getNoteList;
    print(url);

    var res = await http.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${ServiceManager.tokenID}',
      },
    );
    print(res.statusCode);
    if (res.statusCode == 200) {
      print(res.body);

      var data = jsonDecode(res.body);

      //_streamController.add(data['task']);
    }
    return 'Success';
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
      ),
      body: Container(
        decoration: kBackgroundDesign(context),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      _showNoteDialog(context);
                    },
                  ),
                  Text('Add Note'),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        title: Text(notes[index].text),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showNoteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Note'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _textController,
                decoration: InputDecoration(labelText: 'Enter your note'),
                maxLines: 5,
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        // notes.add(Note(text: _textController.text));

                        createNote();
                        _textController.clear();
                        Navigator.of(context).pop();
                      });
                    },
                    child: Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

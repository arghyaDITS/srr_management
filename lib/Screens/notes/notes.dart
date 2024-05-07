import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:srr_management/Screens/Leave/component/approvalPopUp.dart';
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
  //final List<Note> notes = [];
  final TextEditingController _textController = TextEditingController();
  bool isLoading = false;
  final StreamController _streamController = StreamController();

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
      getAllNoteList();
    }
    return 'Success';
  }

  getAllNoteList() async {
    setState(() {
      isLoading = true;
    });
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

      _streamController.add(data);
      setState(() {
        isLoading = false;
      });
    }
    return 'Success';
  }

  updateNote(noteId) async {
    setState(() {
      isLoading = true;
    });
    String url = APIData.updateNote;
    print(ServiceManager.userID);
    print(_textController.text);
    print(url.toString());
    var res = await http.post(Uri.parse(url), headers: APIData.kHeader, body: {
      'id':noteId.toString(),
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
      getAllNoteList();
    }
    return 'Success';
  }

  deleteNotes(noteId) async {
    isLoading = true;
    String url = "${APIData.deleteNote}/$noteId";
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

      _streamController.add(data);
      isLoading = false;
      getAllNoteList();
    }
    return 'Success';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
      ),
      body: StreamBuilder(
          stream: _streamController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var notes = snapshot.data;
              return Container(
                decoration: kBackgroundDesign(context),
                child: SingleChildScrollView(
                    child: isLoading == false
                        ? Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  elevation: 2,
                                  color: const Color.fromARGB(255, 246, 229, 250),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.add),
                                          onPressed: () {
                                            _showNoteDialog(context);
                                          },
                                        ),
                                        const Text('Add Note'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: notes.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      color: Color.fromARGB(255, 238, 214, 255),
                                      child: ListTile(
                                        title:
                                            Text(notes[index]['description'],style: kBoldStyle(),),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.edit),
                                              onPressed: () {
                                                _showNoteDialog(context,
                                                    noteID: notes[index]['id'],
                                                    noteDesc: notes[index]
                                                        ['description']);
                                              },
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.delete),
                                              onPressed: () {
                                                declinePopUp(context, "Delete",
                                                    onClickYes: () {
                                                  deleteNotes(
                                                      notes[index]['id']);

                                                  Navigator.pop(context);
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.5),
                            ],
                          )
                        : const Center(child: LoadingIcon())),
              );
            }
            return const Center(child: LoadingIcon());
          }),
    );
  }

  void _showNoteDialog(BuildContext context, {noteID, noteDesc}) {
    if (noteID != null) {
      _textController.text = noteDesc;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Note'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _textController,
                decoration: const InputDecoration(labelText: 'Enter your note'),
                maxLines: 2,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        // notes.add(Note(text: _textController.text));

                       noteID!=null?updateNote(noteID): createNote();
                        _textController.clear();
                        Navigator.of(context).pop();
                      });
                    },
                    child: Text(noteID != null ? 'Update' : 'Save'),
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

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';

class UserSelectionScreen extends StatefulWidget {
  @override
  _UserSelectionScreenState createState() => _UserSelectionScreenState();
}

class _UserSelectionScreenState extends State<UserSelectionScreen> {
  List<String> selectedUsers = [];
  List<String> allUsers = [
    "User 1",
    "User 2",
    "User 3",
    "User 4",
    "User 5",
    // Add more users as needed
  ];

  String? selectedUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Selection'),
      ),
      body: Column(
        children: [
          SimpleAutoCompleteTextField(
            key: GlobalKey<AutoCompleteTextFieldState<String>>(),
            suggestions: allUsers,
            decoration: const InputDecoration(
              labelText: 'Search for a user',
              border: OutlineInputBorder(),
            ),
            textChanged: (text) {
              selectedUser = text;
            },
            textSubmitted: (text) {
              setState(() {
                if (!selectedUsers.contains(text)) {
                  selectedUsers.add(text);
                }
              });
            },
          ),
          const SizedBox(height: 20),
          const Text(
            'Selected Users:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: selectedUsers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(selectedUsers[index]),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle),
                    onPressed: () {
                      setState(() {
                        selectedUsers.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
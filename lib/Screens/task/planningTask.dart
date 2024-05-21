// import 'package:flutter/material.dart';


// class TaskPlanningListScreen extends StatefulWidget {
//   @override
//   _TaskPlanningListScreenState createState() => _TaskPlanningListScreenState();
// }

// class _TaskPlanningListScreenState extends State<TaskPlanningListScreen> {
//   List<User> users = [
//     User(name: 'User 1', email: 'user1@example.com'),
//     User(name: 'User 2', email: 'user2@example.com'),
//     User(name: 'User 3', email: 'user3@example.com'),
//   ];

//   List<User> archivedUsers = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User List'),
//       ),
//       body: ListView.builder(
//         itemCount: users.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(users[index].name),
//             subtitle: Text(users[index].email),
//             trailing: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.archive),
//                   onPressed: () {
//                     // Move user to archived list
//                     setState(() {
//                       archivedUsers.add(users[index]);
//                       users.removeAt(index);
//                     });
//                   },
//                 ),
//                 Checkbox(
//                   value: false, // Add logic for handling checkbox
//                   onChanged: (bool? value) {
//                     // Remove user from the list
//                     setState(() {
//                       users.removeAt(index);
//                     });
//                   },
//                 ),
//               ],
//             ),
//             onTap: () {
//               // Navigate to new screen
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => UserDetailsScreen(user: users[index]),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// class UserDetailsScreen extends StatelessWidget {
//   final User user;

//   UserDetailsScreen({required this.user});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User Details'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Name: ${user.name}',
//               style: TextStyle(fontSize: 20),
//             ),
//             Text(
//               'Email: ${user.email}',
//               style: TextStyle(fontSize: 20),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

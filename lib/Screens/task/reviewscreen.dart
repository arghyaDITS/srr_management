import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:srr_management/Screens/task/reviewModel.dart';
import 'package:srr_management/components/util.dart';
import 'package:srr_management/services/apiEndpoint.dart';
import 'package:srr_management/services/serViceManager.dart';
import 'package:srr_management/theme/style.dart';
import 'package:http/http.dart' as http;

class ReviewScreen extends StatefulWidget {
  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  // Mock list of reviews
  final List<Review> reviews = [
    Review(id: 1, description: "Great product, highly recommended!", score: 5),
    Review(id: 2, description: "Average product, could be better", score: 3),
    Review(id: 3, description: "Terrible experience, do not buy!", score: 1),
    Review(id: 4, description: "Good product overall, satisfied", score: 4),
    Review(
        id: 5, description: "Could improve in some areas, but okay", score: 3),
  ];
  final StreamController _streamController = StreamController();
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getReviewList();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _streamController.close();
  }

  getReviewList() async {
    String url = APIData.getReviewTask;
    print(url);

    var res = await http.post(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${ServiceManager.tokenID}',
    }, body: {
      'user_id': ServiceManager.userID
    });
    print(res.statusCode);
    if (res.statusCode == 200) {
      print(res.body);

      var data = jsonDecode(res.body);
      _streamController.add(data['data']);
    }
    return 'Success';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews'),
      ),
      body: StreamBuilder(
          stream: _streamController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;

              return data.isNotEmpty
                  ? Container(
                      decoration: kBackgroundDesign(context),
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const Divider(
                          height: 2.0,
                          thickness: 2.0,
                        ),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 2,
                            child: ListTile(
                              title: Text('Task: ${data[index]['get_task']['title']}'),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   Container(
                                    padding: EdgeInsets.all(5),
                                    width: double.maxFinite,
                                      color: Color.fromARGB(255, 220, 234, 232),
                                      child: Text("${data[index]['review']}")),
                                  
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      const Text('Rating: '),
                                      const Icon(Icons.star,
                                          color: Colors.amber, size: 20),
                                      Text('${data[index]['rating']}/5'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Container(
                      decoration: kBackgroundDesign(context),
                      child: Center(
                        child: Text(
                          "No Reviews yet",
                          style: kBoldStyle(),
                        ),
                      ));
            }
            return const Center(child: LoadingIcon());
          }),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:srr_management/Screens/task/reviewModel.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getReviewList();
  }

  getReviewList()async
  { String url = APIData.getReviewTask;
    print(url);

    var res = await http.post(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${ServiceManager.tokenID}',
    }, body: {
      'user_id':ServiceManager.userID

      
    });
    print(res.statusCode);
    if (res.statusCode == 200) {
      print(res.body);

      var data = jsonDecode(res.body);

    
    }
    return 'Success';

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews'),
      ),
      body: Container(
        decoration: kBackgroundDesign(context),
        child: ListView.separated(
          separatorBuilder: (context, index) => const Divider(
            height: 2.0,
            thickness: 2.0,
          ),
          itemCount: reviews.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 2,
              child: ListTile(
                title: Text('Task ID: ${reviews[index].id}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(reviews[index].description),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Text('Score: '),
                        const Icon(Icons.star, color: Colors.amber, size: 20),
                        Text('${reviews[index].score}/5'),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

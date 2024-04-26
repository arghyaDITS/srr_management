import 'package:flutter/material.dart';
import 'package:srr_management/Screens/task/reviewModel.dart';
import 'package:srr_management/theme/style.dart';

class ReviewScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews'),
      ),
      body: Container(
        decoration: kBackgroundDesign(context),
        child: ListView.separated(
          separatorBuilder: (context, index) => Divider(height: 2.0,thickness: 2.0,),
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
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text('Score: '),
                        Icon(Icons.star, color: Colors.amber, size: 20),
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

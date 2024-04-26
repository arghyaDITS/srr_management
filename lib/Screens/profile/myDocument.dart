
import 'package:flutter/material.dart';
import 'package:srr_management/Screens/profile/component/document.dart';
import 'package:srr_management/theme/colors.dart';
import 'package:srr_management/theme/style.dart';

class MyDocument extends StatefulWidget {
  const MyDocument({Key? key}) : super(key: key);

  @override
  State<MyDocument> createState() => _MyDocumentState();
}

class _MyDocumentState extends State<MyDocument> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: k2MainColor,
        title: Text('My Document'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Row(
                children: [
                  docButton(context,
                    onView: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => Document(title: 'Appointment Letter')));
                    },
                    onDownload: (){},
                    title: 'Appointment Letter',
                  ),
                  docButton(context,
                    onView: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => Document(title: 'Joining Letter')));
                    },
                    onDownload: (){},
                    title: 'Joining Letter',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Expanded docButton(BuildContext context, {
  required Function() onView,
  required Function() onDownload,
  required String title,
}) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: roundedContainerDesign(context),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5.0),
            Container(
              height: 50.0,
              width: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                image: DecorationImage(
                  image: AssetImage('images/pdf.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Text(title),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: onView,
                  icon: Icon(Icons.visibility_outlined),
                ),
                IconButton(
                  onPressed: onDownload,
                  icon: Icon(Icons.file_download_outlined),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

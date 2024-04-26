import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Document extends StatelessWidget {

  String title;
  Document({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      // body: Image.asset(title == 'Appointment Letter' ?
      // 'images/appointment.jpeg' : 'images/offerLetter.jpeg'),
      body:Container(child:  SfPdfViewer.network(
          'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf')),
    );
  }
}

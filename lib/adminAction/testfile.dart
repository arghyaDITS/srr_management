import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

class FileUploadScreen extends StatefulWidget {
  @override
  _FileUploadScreenState createState() => _FileUploadScreenState();
}

class _FileUploadScreenState extends State<FileUploadScreen> {
  File? _file;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc'],
    );

    if (result != null) {
      setState(() {
        _file = File(result.files.single.path!);
      });
    } else {
      // User canceled the picker
    }
  }

  Future<void> _uploadFile() async {
    if (_file == null) {
      // Show error message that no file is selected
      return;
    }

    try {
      String fileName = basename(_file!.path);
      String apiUrl = 'YOUR_API_ENDPOINT_HERE';

      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          _file!.path,
          filename: fileName,
          contentType: MediaType('application', 'pdf'), // Change content type according to file type
        ),
      });

      Response response = await Dio().post(apiUrl, data: formData);
      
      // Handle response according to your requirements

    } catch (e) {
      // Handle errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Upload'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _file != null
                ? Text('Selected file: ${basename(_file!.path)}')
                : Text('No file selected'),
            ElevatedButton(
              onPressed: _pickFile,
              child: Text('Select File'),
            ),
            ElevatedButton(
              onPressed: _uploadFile,
              child: Text('Upload File'),
            ),
          ],
        ),
      ),
    );
  }
}
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:srr_management/components/buttons.dart';
import 'package:srr_management/components/custom_textField.dart';
import 'package:srr_management/services/apiEndpoint.dart';
import 'package:srr_management/services/serViceManager.dart';
import 'package:srr_management/theme/style.dart';
import 'package:http/http.dart' as http;

class ForgetPasswordScreen extends StatefulWidget {
  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  bool isLoading = false;

  // void _resetPassword(BuildContext context) async {
  //   try {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text("Password reset link sent to your email"),
  //       ),
  //     );
  //   } catch (error) {
  //     // Handle error
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text("Error: ${error.toString()}"),
  //       ),
  //     );
  //   }
  // }

  sendresetLink() async {
    setState(() {
      isLoading = true;
    });
    String url = APIData.forgotPassLink;
    print(url);

    var res = await http.post(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${ServiceManager.tokenID}',
    }, body: {
      'email': emailController.text
    });
    print(res.statusCode);
    if (res.statusCode == 200) {
      //  print(res.body);

      var data = jsonDecode(res.body);
      print(data.toString());
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Password reset link sent to your email"),
        ),
      );
      Navigator.of(context).pop();
    }
    return 'Success';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forget Password"),
      ),
      body: Container(
        decoration: kBackgroundDesign(context),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              KTextField(
                title: 'Email',
                controller: emailController,
                textInputType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: KButton(
                  onClick: () => sendresetLink(),
                  title: 'Send reset link',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

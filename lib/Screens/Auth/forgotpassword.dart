
import 'package:flutter/material.dart';
import 'package:srr_management/components/buttons.dart';
import 'package:srr_management/components/custom_textField.dart';

class ForgetPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  void _resetPassword(BuildContext context) async {
    try {
      // await FirebaseAuth.instance.sendPasswordResetEmail(
      //   email: emailController.text.trim(),
      // );
      // Show a success message or navigate to another screen
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Password reset link sent to your email"),
        ),
      );
    } catch (error) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: ${error.toString()}"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forget Password"),
      ),
      body: Padding(
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
                onClick: () => _resetPassword(context),
                       title: 'Send reset link',
               ),
             ),
           
          ],
        ),
      ),
    );
  }
}

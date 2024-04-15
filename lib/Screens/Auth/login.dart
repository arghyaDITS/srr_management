import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:srr_management/Screens/Auth/registration.dart';
import 'package:srr_management/Screens/Home/home.dart';
import 'package:srr_management/components/buttons.dart';
import 'package:srr_management/components/custom_textField.dart';
import 'package:srr_management/theme/style.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isObscure = true;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue[100],
        title: const Text('Login'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Image.asset(
              'images/logo.jpg',
              height: 100,
              width: 100,
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                  "Please enter your valid email address, we don't share it with anyone without your consent"),
            ),
            const SizedBox(height: 40),
            KTextField(
              title: 'Email',
              controller: email,
              textInputType: TextInputType.emailAddress,
            ),
            KTextField(
              title: 'Password',
              controller: password,
              obscureText: isObscure,
              suffixButton: IconButton(
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
                icon: Icon(!isObscure
                    ? Icons.visibility_off_outlined
                    : Icons.visibility),
              ),
            ),
            kSpace(),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodySmall!.color),
                children: <TextSpan>[
                  TextSpan(text: 'Not a registered user ? '),
                  TextSpan(
                    text: 'Sign up',
                    style: linkTextStyle(context),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Registration()));
                      },
                  ),
                ],
              ),
            ),
            kSpace(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodySmall!.color),
                      children: <TextSpan>[
                        const TextSpan(text: 'By continuing you agree to '),
                        TextSpan(
                          text: 'Terms of Use',
                          style: linkTextStyle(context),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Navigator.push(context, MaterialPageRoute(
                              //     builder: (context) => TermsAndCondition()));
                            },
                        ),
                        const TextSpan(text: ' & '),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: linkTextStyle(context),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Navigator.push(context, MaterialPageRoute(
                              //     builder: (context) => PrivacyPolicy()));
                            },
                        ),
                      ])),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: isLoading != true ? KButton(
          title: 'Login',
          onClick: (){
            if(_formKey.currentState!.validate()){
              // setState(() {
              //   isLoading = true;
              // });
            
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Home()));
                      
              
             // loginUser(context);
            }
          },
        ) : LoadingButton(),
    );
  }
}

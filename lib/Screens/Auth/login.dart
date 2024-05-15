import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:srr_management/Screens/Auth/forgotpassword.dart';
import 'package:srr_management/Screens/Auth/registration.dart';
import 'package:srr_management/Screens/Home/dashboard.dart';
import 'package:srr_management/Screens/Home/home.dart';
import 'package:srr_management/components/buttons.dart';
import 'package:srr_management/components/custom_textField.dart';
import 'package:srr_management/components/util.dart';
import 'package:srr_management/services/apiEndpoint.dart';
import 'package:srr_management/services/serViceManager.dart';
import 'package:srr_management/theme/style.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

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
    String message = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email.text = "krishnabasak.dits@gmail.com";
    password.text = "12345678";
   // checkDeviceType();
  }
  //   Future<void> checkDeviceType() async {
  //   String platform = '';
  //   try {
  //     platform = await MethodChannel('samples.flutter.dev/device_info')
  //         .invokeMethod('getPlatform');
  //   } on PlatformException catch (e) {
  //     print("Failed to get platform: '${e.message}'.");
  //   }

  //   setState(() {
  //     if (platform == 'tv') {
  //       message = 'Welcome to TV';
  //     } else {
  //       message = 'Welcome to App';
  //     }
  //   });
  // }
  

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
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Image.asset(
                'images/srr_logo.png',
                height: 100,
                width: 100,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                    textAlign: TextAlign.center,
                    style: kHeaderStyle(color: Colors.blueGrey),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: TextButton(
                      child: Text(
                        "Forgotten Password?",
                        style: linkTextStyle(context),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgetPasswordScreen(),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodySmall!.color),
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: isLoading != true
          ? KButton(
              title: 'Login',
              onClick: () {
                if (_formKey.currentState!.validate()) {
                  // setState(() {
                  //   isLoading = true;
                  // });
                  loginUser(context);

                  // loginUser(context);
                }
              },
            )
          : LoadingButton(),
    );
  }

  Future<String> loginUser(context) async {
    setState(() {
      isLoading=true;
    });
    String url = APIData.login;
    print(url.toString());
    var res = await http.post(Uri.parse(url), body: {
      'email': email.text,
      'password': password.text,
    });
    if (res.statusCode == 200) {
      print("______________________________________");
      print(res.body);
      print("______________________________________");
      var data = jsonDecode(res.body);
      try {
        print('${data['userInfo']['id']}');
         ServiceManager().setUser('${data['userInfo']['id']}');
         ServiceManager().setToken('${data['token']}');
        ServiceManager.userID = '${data['userInfo']['id']}';
       ServiceManager.tokenID = '${data['token']}';
        toastMessage(message: 'Logged In');
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => Home()), (route) => false);
      } catch (e) {
        toastMessage(message: e.toString());
        setState(() {
          isLoading = false;
        });
        toastMessage(message: 'Something went wrong');
      }
    } else {
      setState(() {
        isLoading = false;
      });
      toastMessage(message: 'Invalid email or password');
    }
    setState(() {
      isLoading=false;
    });
    return 'Success';
  }
}

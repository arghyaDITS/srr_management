import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:srr_management/Screens/Auth/login.dart';
import 'package:srr_management/components/buttons.dart';
import 'package:srr_management/components/custom_textField.dart';
import 'package:srr_management/theme/style.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {

  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  bool agreeWithTerms = false;
  bool loading = false;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    // getToken();
  }

  // String firebaseFCMToken = '';
  // void getToken() async {
  //   firebaseFCMToken = (await FirebaseMessaging.instance.getToken())!;
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBackgroundDesign(context),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Sign Up'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Image.asset('images/app_logo.png', height: 250),
                Column(
                  children: [
                    KTextField(
                      title: 'Name',
                      controller: name,
                    ),
                    KTextField(
                      title: 'Email',
                      controller: email,
                      textInputType: TextInputType.emailAddress,
                    ),
                    KTextField(
                      title: 'Mobile',
                      controller: mobile,
                      textLimit: 10,
                      textInputType: TextInputType.number,
                    ),
                    KTextField(
                      title: 'Password',
                      controller: password,
                      obscureText: obscurePassword,
                      suffixButton: IconButton(
                        onPressed: (){
                          setState(() {
                            obscurePassword = !obscurePassword;
                          });
                        },
                        icon: Icon(obscurePassword ?
                        Icons.visibility_outlined : Icons.visibility_off_outlined),
                      ),
                    ),
                    KTextField(
                      title: 'Confirm Password',
                      controller: confirmPassword,
                      obscureText: obscureConfirmPassword,
                      suffixButton: IconButton(
                        onPressed: (){
                          setState(() {
                            obscureConfirmPassword = !obscureConfirmPassword;
                          });
                        },
                        icon: Icon(obscureConfirmPassword ?
                        Icons.visibility_outlined : Icons.visibility_off_outlined),
                      ),
                    ),
                    SizedBox(height: 5.0),
                  ],
                ),
                kSpace(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CupertinoSwitch(
                        value: agreeWithTerms,
                        onChanged: (value){
                          setState(() {
                            agreeWithTerms = value;
                          });
                        },
                      ),
                      SizedBox(width: 5.0),
                      Expanded(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color),
                            children: <TextSpan>[
                              TextSpan(text: 'I agree with '),
                              TextSpan(
                                text: 'Term & condition',
                                style: linkTextStyle(context),
                                recognizer: TapGestureRecognizer()..onTap = () {
                                  // Navigator.push(context, MaterialPageRoute(
                                  //     builder: (context) => TermsAndCondition()));
                                },
                              ),
                              TextSpan(text: ' and '),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: linkTextStyle(context),
                                recognizer: TapGestureRecognizer()..onTap = () {
                                  // Navigator.push(context, MaterialPageRoute(
                                  //     builder: (context) => PrivacyPolicy()));
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                if(agreeWithTerms != false && loading != true)
                KButton(
                  title: "Sign Up",
                  onClick: (){
                    // if(_formKey.currentState!.validate()){
                    //   Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationScreen()));
                    //   // if(password.text == confirmPassword.text) {
                    //   //   setState(() {
                    //   //     loading = true;
                    //   //   });
                    //   // } else {
                    //   //   // toastMessage(message: "Password doesn't match");
                    //   // }
                    // }
                  },
                ),
                if(loading != false)
                  LoadingButton(),
                kSpace(),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color),
                    children: <TextSpan>[
                      TextSpan(text: 'Already a registered user ? '),
                      TextSpan(
                        text: 'Sign In',
                        style: linkTextStyle(context),
                        recognizer: TapGestureRecognizer()..onTap = () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                        },
                      ),
                    ],
                  ),
                ),
                kBottomSpace(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Future<void> registerWithEmailAndPassword({
  //   required String email, required String password
  // }) async {
  //   try {
  //     UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     User? user = userCredential.user;
  //     if (user != null) {
  //       setState(() {
  //         ServiceManager.userID = user.uid;
  //       });
  //       createUser(user.uid);
  //     } else {
  //       toastMessage(message: 'Registration Failed');
  //     }
  //   } catch (e) {
  //     toastMessage(message: 'Email already used');
  //   }
  // }
  //
  // void createUser(String userID) {
  //   _firestore.collection('users').doc(userID).set({
  //     'FCM': firebaseFCMToken,
  //     'created_at': DateTime.now(),
  //     'description': '',
  //     'dob': '',
  //     'email': email.text,
  //     'firstName': ServiceManager().getFirstName(name.text),
  //     'gender': '',
  //     'image': '',
  //     'isVerified': false,
  //     'lastName': ServiceManager().getLastName(name.text),
  //     'licence': '',
  //     'licenceBack': '',
  //     'licenceFront': '',
  //     'mobile': mobile.text,
  //     'organizationEmail': '',
  //     'vehicleColor': '',
  //     'vehicleName': '',
  //     'vehiclePlateImage': '',
  //     'vehiclePlateNo': '',
  //   }).then((value) => {
  //     ServiceManager().setUser(userID),
  //   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
  //       builder: (context) => NavigationScreen()), (route) => false),
  //   });
  // }
}
//test

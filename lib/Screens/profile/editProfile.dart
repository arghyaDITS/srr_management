import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:srr_management/components/buttons.dart';
import 'package:srr_management/components/custom_textField.dart';
import 'package:srr_management/components/dataBase.dart';
import 'package:srr_management/components/imgPickerPopup.dart';
import 'package:srr_management/components/util.dart';
import 'package:srr_management/services/apiEndpoint.dart';
import 'package:srr_management/services/serViceManager.dart';
import 'package:srr_management/theme/colors.dart';
import 'package:srr_management/theme/style.dart';
import 'package:http/http.dart' as http;

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();

  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController whatsapp = TextEditingController();
  TextEditingController emergencyNumber = TextEditingController();
  TextEditingController presentAddress = TextEditingController();

  String profileURL = '';
  String roleValue = '';
  String departmentValue = '';
  String genderValue = '';
  String maritalValue = '';
  String bloodValue = '';
  bool isAdmin = false;
  bool isLoading = true;
  bool uploading = false;

  final ImagePicker _picker = ImagePicker();
  File? _image;
  // var image;

  void _imgFromGallery() async {
    var pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage!.path);
    });
  }

  void _imgFromCamera() async {
    var pickedImage = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = File(pickedImage!.path);
    });
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context, int type) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      if (type == 1) {
        setState(() {
          dateOfBirth.text =
              '${selectedDate.day}-${selectedDate.month}-${selectedDate.year}';
        });
      } else if (type == 2) {
        // setState(() {
        //   joiningDate.text =
        //       '${selectedDate.day}-${selectedDate.month}-${selectedDate.year}';
        // });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    // ServiceManager().getUserData();
    getUserData();
  }

  void getUserData() async {
    setState(() {
      isLoading = true;
    });
    String url = APIData.userDetails;
    print(url);
    var res = await http.get(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${ServiceManager.tokenID}',
    });
    print(res.statusCode);
    if (res.statusCode == 200) {
      print(res.body);
      var data = jsonDecode(res.body);
      profileURL = '${data['user']['profile_image']}';
      name.text = '${data['user']['name']}';
      email.text = '${data['user']['email']}';
      mobile.text = data['user']['phone_no'] ?? '';
      genderValue = data['user']['gender'] == 'female'
          ? "Female"
          : data['user']['gender'] == 'male'
              ? "Male"
              : "Other";
      maritalValue = data['user']['marital_status'] == 'married'
          ? "Married"
          : "Unmarried";
         presentAddress.text=data['user']['present_address'];
         dateOfBirth.text=data['user']['dob'];
    }
    setState(() {
      isLoading = false;
    });
  }

  updateUserData() async {
    print("without iamge");
    // setState(() {
    //   isLoading = true;
    // });
    String url = APIData.updateUser;
    // String base64Image = '';
    // if (_image != null) {
    //   List<int> imageBytes = await _image!.readAsBytes();
    //   base64Image = base64Encode(imageBytes);
    //   print(base64Image.toString());
    // }
    print(url);
    var res = await http.post(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${ServiceManager.tokenID}',
    }, body: {
      'user_id': ServiceManager.userID,
      'name': name.text,
      'email': email.text,
      'phone': mobile.text,
      // 'profile_image': base64Image,
      'dob': dateOfBirth.text,
      'gender': genderValue,
      'marital_status': maritalValue,
      'present_address': presentAddress.text
    });
    print(res.statusCode);
    if (res.statusCode == 200) {
      print(res.body);
      var data = jsonDecode(res.body);
      print(data.toString());
       toastMessage(message: 'Profile Updated');
      Navigator.pop(context);
      // setState(() {
      //   isLoading = false;
      // });

      // _streamController.add(data['data']);
    }
    return 'Success';
  }

  Future<String> updateProfileWithImage(context) async {
    print("with iamge");
    setState(() {
      isLoading = true;
    });
    Map<String, String> formData = {
      'user_id': ServiceManager.userID,
      'name': name.text,
      'email': email.text,
      'phone': mobile.text,
      'dob': dateOfBirth.text,
      'gender': genderValue,
      'marital_status': maritalValue,
      'present_address': presentAddress.text
    };
    String url = APIData.updateUser;
    print(url);
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields.addAll(formData);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${ServiceManager.tokenID}',
    };
    request.headers.addAll(headers);
    if (_image != null) {
      request.files.add(
        await http.MultipartFile.fromPath('profile_image', _image!.path),
      );
    }
    print("**************");
    print(formData.toString());
    print("**************");
    var response = await request.send();
    var responseString = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      setState(() {
        ServiceManager.profileURL = _image!.path;
      });
      toastMessage(message: 'Profile Updated');
      Navigator.pop(context);
    } else {
      toastMessage(message: 'Server Error');
    }

    print('Response status: ${response.statusCode}');
    print('Response body: $responseString');
    return 'Success';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(0.0),
          child:
              // isLoading ? LinearProgressIndicator(color: kMainColor) :
              SizedBox.shrink(),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: kBackgroundDesign(context),
          child: Column(
            children: [
              kSpace(),
              Stack(
                children: [
                  //  const CircleAvatar(
                  //       radius: 70,
                  //       backgroundImage: AssetImage('images/img_blank_profile.png'),
                  //     ) ,
                  CircleAvatar(
                    radius: 75,
                    backgroundColor:
                        Theme.of(context).scaffoldBackgroundColor !=
                                Colors.black
                            ? Colors.white
                            : kDarkColor,
                    child: _image != null
                        ? CircleAvatar(
                            radius: 70,
                            backgroundImage: FileImage(File(_image!.path)),
                          )
                        : ServiceManager.profileURL == ''
                            ? const CircleAvatar(
                                radius: 70,
                                backgroundImage:
                                    AssetImage('images/img_blank_profile.png'),
                              )
                            : CircleAvatar(
                                radius: 70,
                                backgroundImage:
                                    NetworkImage(ServiceManager.profileURL),
                              ),
                  ),
                  Positioned(
                    right: 0.0,
                    bottom: 0.0,
                    child: CircleAvatar(
                      backgroundColor: Colors.black.withOpacity(0.6),
                      radius: 20,
                      child: IconButton(
                        icon: const Icon(Icons.edit_outlined),
                        color: Colors.white,
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return ImagePickerPopUp(
                                onCameraClick: () {
                                  Navigator.pop(context);
                                  _imgFromCamera();
                                },
                                onGalleryClick: () {
                                  Navigator.pop(context);
                                  _imgFromGallery();
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              kSpace(),
              KTextField(
                title: 'Name',
                controller: name,
              ),
              KTextField(
                title: 'Email',
                textInputType: TextInputType.emailAddress,
                controller: email,
              ),
              KTextField(
                title: 'Mobile Number',
                textInputType: TextInputType.number,
                textLimit: 10,
                controller: mobile,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kDropDownHintText('Gender'),
                    Container(
                      height: dropdownTextFieldHeight(),
                      width: MediaQuery.of(context).size.width,
                      decoration: dropTextFieldDesign(context),
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton(
                            borderRadius: BorderRadius.circular(10.0),
                            value: genderValue != '' ? genderValue : null,
                            hint: const Text('Gender'),
                            items: genderList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                genderValue = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kDropDownHintText('Marital Status'),
                    Container(
                      height: dropdownTextFieldHeight(),
                      width: MediaQuery.of(context).size.width,
                      decoration: dropTextFieldDesign(context),
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton(
                            borderRadius: BorderRadius.circular(10.0),
                            value: maritalValue != '' ? maritalValue : null,
                            hint: const Text('Marital Status'),
                            items: maritalList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                maritalValue = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              KTextField(
                title: 'Date of Birth',
                controller: dateOfBirth,
                suffixButton: IconButton(
                  onPressed: () {
                    _selectDate(context, 1);
                  },
                  icon: const Icon(Icons.calendar_month),
                ),
              ),
              KTextField(
                title: 'Present Address',
                controller: presentAddress,
              ),
              kBottomSpace(),
            ],
          ),
        ),
      ),
      floatingActionButton: KButton(
        title: 'Update',
        onClick: () {
          if (_image != null) {
            updateProfileWithImage(context);
          } else {
            updateUserData();
          }

          // Navigator.pop(context);
          toastMessage(message: 'Profile Updated');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

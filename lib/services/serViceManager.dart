import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:srr_management/services/apiEndpoint.dart';

class ServiceManager {

  static String userID = '';
  static String tokenID = '';
  static String userBranchID = '';

  static String profileURL = '';
  static String userName = '';
  static String userEmail = '';
  static String userMobile = '';
  static String userDob = '';
  static String userAltMobile = '';
  static String designation = '';
  static bool isVerified = false;

  static String deliveryName = '';
  // static String deliveryAddress = '';

  static String userAddress = '';
  static String addressID = '';
  static String roleAs = '';

  void setUser (String userID) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userID', userID);
  }

  void getUserID () async {
    final prefs = await SharedPreferences.getInstance();
    userID = prefs.getString('userID') ?? '';
    // getUserData();
  }

  void setToken (String userID) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('tokenID', userID);
  }

  void getTokenID () async {
    final prefs = await SharedPreferences.getInstance();
    tokenID = prefs.getString('tokenID') ?? '';
    getUserData();
  }

  void setAddressID (String addressID) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('addressID', addressID);
  }

  void getAddressID () async {
    final prefs = await SharedPreferences.getInstance();
    addressID = prefs.getString('addressID') ?? '';
  }

  void removeAll() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userID');
    prefs.remove('tokenID');
    // prefs.remove('addressID');
    userID = '';
    tokenID = '';
    // addressID = '';
  }

  void getUserData() async {
    String url = APIData.userDetails;
    print(url);
   var res = await http.get(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${ServiceManager.tokenID}',
    });
    if(res.statusCode == 200){
      var data = jsonDecode(res.body);
      print(data.toString());
      userName = '${data['user']['name']}';
      userEmail = '${data['user']['email']}';
      profileURL = '${data['user']['photo']}';
      userMobile = data['user']['mobile'] ?? '';
      userAltMobile = data['user']['alternative_mob'] ?? '';
      userDob = data['user']['dob'] ?? '';
      designation = data['user']['Designation'] ?? '';
      userBranchID = data['user']['branchId'] ?? '';
      roleAs='${data['user']['role_as']}';
    } else {
      // print('Status Code: ${res.statusCode}');
      // print(res.body);
    }
  }
}
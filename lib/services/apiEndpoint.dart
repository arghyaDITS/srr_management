import 'package:srr_management/services/serViceManager.dart';

class APIData {
  // static const String baseURL = 'https://devanthosting.com/salon/api/';
  static const String baseURL = 'https://devanthosting.cloud/srr_api/';

  static const String login = '${baseURL}api/login';

  static const String userDetails = '${baseURL}api/user-data';

  static const String updateUser = '${baseURL}api/update_user';

  //Task Api
  static const String createTask='${baseURL}api/create_task';
  static const String upDateTask='${baseURL}api/update_task';
  static const String getAllTaskForAdmin='${baseURL}api/get_task';

  //Leave Api
  static const String getTotalLeaveList='${baseURL}api/getLeaves';
   static const String applyLeave='${baseURL}api/saveLeaves';
   static const String changeLeaveStatus='${baseURL}api/updateStatus';
   static const String userWiseLeave='${baseURL}api/userWiseLeave';
  static const String userSingleLeave= '${baseURL}api/user_wise_leave_with_id';


  static Map<String, String> kHeader = {
    'Accept': 'application/json',
    'Authorization': 'Bearer ${ServiceManager.tokenID}',
  };
}

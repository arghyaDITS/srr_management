import 'package:srr_management/services/serViceManager.dart';

class APIData {
  //Auth profile Api
  static const String baseURL = 'https://devanthosting.cloud/srr_api/';

  static const String login = '${baseURL}api/login';

  static const String userDetails = '${baseURL}api/user-data';

  static const String updateUser = '${baseURL}api/update_user';
  static const String getUserList = '${baseURL}api/get_user_list';

  //Task Api
  static const String createTask = '${baseURL}api/create_task';
  static const String upDateTask = '${baseURL}api/update_task';
  static const String getAllTaskForAdmin = '${baseURL}api/get_task';
  static const String getTaskById = '${baseURL}api/get_task_by_id';
  static const String deleteTaskByAdmin = '${baseURL}api/delete_task';

  //user task
  static const String getUserTotalTask = '${baseURL}api/get_task_for_user';

  static const String changeTaskStatus = '${baseURL}api/task_status_update';
  //issue task
  static const String createIssue = '${baseURL}api/create_task_issue';
  static const String getIssue = '${baseURL}api/get_issue_for_admin';
  static const String getIssueForUser = '${baseURL}api/get_issue_for_user';
  static const String fixIssue = '${baseURL}api/resolve_task_issue';

  static const String archivedTask = '${baseURL}api/task_arcrived';
  static const String reviewTaskbyAdmin = '${baseURL}api/create_task_review';
  static const String getReviewTask = '${baseURL}api/get_task_review';

  static const String archivedTaskListForUser =
      '${baseURL}api/get_archive_task_for_user';
      

  static const String todaysTaskListForUser =
      '${baseURL}api/get_today_task_for_user';

  //Leave Api
  static const String getTotalLeaveList = '${baseURL}api/getLeaves';
  static const String applyLeave = '${baseURL}api/saveLeaves';
  static const String editLeave = '${baseURL}api/updateLeaves';
  static const String changeLeaveStatus = '${baseURL}api/updateStatus';
  static const String userWiseLeave = '${baseURL}api/userWiseLeave';
  static const String userSingleLeave = '${baseURL}api/user_wise_leave_with_id';

  //notes Api
  static const String postNote = '${baseURL}api/saveNotes';

  static const String getNoteList = '${baseURL}api/getNotes';
  static const String updateNote = '${baseURL}api/updateNotes';

  static const String deleteNote = '${baseURL}api/deleteNotes';

  static Map<String, String> kHeader = {
    'Accept': 'application/json',
    'Authorization': 'Bearer ${ServiceManager.tokenID}',
  };
}

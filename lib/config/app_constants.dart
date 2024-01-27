class AppConstants {
  // API Constants
  static const String baseUrl = 'https://api-todo-list.jotno.dev';
  // user based
  static const String login = '$baseUrl/user/login';
  static const String register = '$baseUrl/user/register';
  static const String logout = '$baseUrl/user/logout';
  static const String profileUpdate = '$baseUrl/user/me';
  static const String profileImageUpdate = '$baseUrl/user/me/avatar';
  // task based
  static const String task = '$baseUrl/task';

  // Database Constants
  static const String databaseName = "taskTracker.db";
  static const int dbVersion = 1;
  static const String userTable = 'users';
}

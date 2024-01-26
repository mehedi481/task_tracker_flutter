class AppConstants {
  // API Constants
  static const String baseUrl = 'https://api-todo-list.jotno.dev';
  // user based
  static const String login = '$baseUrl/user/login';
  static const String register = '$baseUrl/user/register';
  static const String logout = '$baseUrl/user/logout';
  // task based
  static const String task = '$baseUrl/task';

  // Hive Box
  static const String authBox = 'authBox';

  // Auth Variable Names
  static const String authToken = 'token';
}

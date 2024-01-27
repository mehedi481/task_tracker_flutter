import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:task_tracker_flutter/views/auth/login_view.dart';
import 'package:task_tracker_flutter/views/auth/signUp_view.dart';
import 'package:task_tracker_flutter/views/core/core_view.dart';
import 'package:task_tracker_flutter/views/profile/components/profile_update.dart';
import 'package:task_tracker_flutter/views/splash/splash_view.dart';
import 'package:task_tracker_flutter/views/task/components/add_task.dart';
import 'package:task_tracker_flutter/views/task/components/update_task.dart';

class Routes {
  Routes._();
  static const String splash = '/';
  static const String logIn = '/signIn';
  static const String signUp = '/signUp';
  static const String core = '/core';
  static const String addTask = '/addTask';
  static const String updateTask = '/updateTask';
  static const String profileDetails = '/profileDetails';
}

Route generatedRoutes(RouteSettings settings) {
  Widget child;

  switch (settings.name) {
    case Routes.splash:
      child = const SplashView();
      break;
    case Routes.logIn:
      child = const LoginView();
      break;
    case Routes.signUp:
      child = const SignUpView();
      break;
    case Routes.core:
      child = const CoreView();
      break;
    case Routes.addTask:
      child = const AddTask();
      break;
    case Routes.updateTask:
      final data = settings.arguments as Map<String, dynamic>;
      child = UpdateTask(
        id: data['id'],
        title: data['title'],
        description: data['description'],
        isComplete: data['isComplete'],
      );
      break;
    case Routes.profileDetails:
      final data = settings.arguments as Map<String, dynamic>;
      child = ProfileUpdate(
        userData: data['userData'],
      );
      break;

    default:
      throw Exception('Invalid route: ${settings.name}');
  }
  return PageTransition(
    child: child,
    type: PageTransitionType.fade,
    settings: settings,
    duration: const Duration(milliseconds: 300),
    reverseDuration: const Duration(milliseconds: 300),
  );
}

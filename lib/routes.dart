import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:task_tracker_flutter/views/auth/layouts/signUp_layout.dart';
import 'package:task_tracker_flutter/views/auth/login_view.dart';
import 'package:task_tracker_flutter/views/auth/signUp_view.dart';
import 'package:task_tracker_flutter/views/splash/splash_view.dart';

class Routes {
  Routes._();
  static const String splash = '/';
  static const String logIn = '/signIn';
  static const String signUp = '/signUp';
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

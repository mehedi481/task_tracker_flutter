import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_tracker_flutter/controllers/auth_controller/login_controller.dart';
import 'package:task_tracker_flutter/controllers/auth_controller/logout_controller.dart';
import 'package:task_tracker_flutter/controllers/auth_controller/register_controller.dart';

final loginControllerProvider = StateNotifierProvider<LoginController, bool>(
  (ref) => LoginController(ref),
);

final registerControllerProvider =
    StateNotifierProvider<RegisterController, bool>(
  (ref) => RegisterController(ref),
);

final logoutControllerProvider = StateNotifierProvider<LogoutController, bool>(
  (ref) => LogoutController(ref),
);

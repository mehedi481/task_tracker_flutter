import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_tracker_flutter/config/app_constants.dart';
import 'package:task_tracker_flutter/services/auth_service_provider.dart';

class LoginController extends StateNotifier<bool> {
  final Ref ref;
  LoginController(this.ref) : super(false);

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    state = true;
    try {
      final response = await ref
          .read(authServiceProvider)
          .login(email: email, password: password);
      Box authBox = Hive.box(AppConstants.authBox);
      authBox.put(AppConstants.authToken, response.data['token']);
      return true;
    } catch (e) {
      return false;
    } finally {
      state = false;
    }
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_tracker_flutter/config/app_constants.dart';
import 'package:task_tracker_flutter/services/auth_service_provider.dart';

class RegisterController extends StateNotifier<bool> {
  final Ref ref;
  RegisterController(this.ref) : super(false);

  Future<bool> register({
    required String name,
    required String email,
    required String password,
    String age = "25",
  }) async {
    state = true;
    try {
      final response = await ref
          .read(authServiceProvider)
          .register(name: name, email: email, password: password, age: age);
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

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_tracker_flutter/controllers/misc/misc_provider.dart';
import 'package:task_tracker_flutter/models/user_model.dart';
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

      // Parse user data from the response
      UserModel user = UserModel.fromJson(response.data['user']);
      String token = response.data['token'];

      // Store user data and token in SQLite database
      await ref.read(databaseHelperProvider).insertUser(user);
      await ref.read(databaseHelperProvider).insertUserToken(token);
      return true;
    } catch (e) {
      return false;
    } finally {
      state = false;
    }
  }
}

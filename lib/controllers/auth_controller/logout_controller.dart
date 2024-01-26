import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_tracker_flutter/services/auth_service_provider.dart';

class LogoutController extends StateNotifier<bool> {
  final Ref ref;
  LogoutController(this.ref) : super(false);

  Future<bool> logout() async {
    try {
      state = true;
      final response = await ref.read(authServiceProvider).logout();
      state = false;
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      state = false;
      rethrow;
    }
  }
}

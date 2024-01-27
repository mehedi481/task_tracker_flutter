import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_tracker_flutter/controllers/misc/misc_provider.dart';
import 'package:task_tracker_flutter/models/user_model.dart';
import 'package:task_tracker_flutter/services/profile_service_provider.dart';

class ProfileUpdateController extends StateNotifier<bool> {
  ProfileUpdateController(this.ref) : super(false);

  final Ref ref;

  Future<bool> updateProfileData({required Map<String, dynamic> data}) async {
    state = true;
    try {
      final response =
          await ref.read(profileServiceProvider).profileUpdate(data: data);
      if (response.statusCode == 200) {
        UserModel user = UserModel.fromJson(response.data['data']);
        await ref.read(databaseHelperProvider).updateUser(user);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    } finally {
      state = false;
    }
  }
}

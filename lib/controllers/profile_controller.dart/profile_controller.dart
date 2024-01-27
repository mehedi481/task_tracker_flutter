import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_tracker_flutter/controllers/misc/misc_provider.dart';
import 'package:task_tracker_flutter/models/user_model.dart';

class ProfileDataController extends StateNotifier<bool> {
  ProfileDataController(this.ref) : super(false) {
    getProfileData();
  }
  final Ref ref;
  UserModel? _userData;
  UserModel? get userData => _userData;

  Future<void> getProfileData() async {
    try {
      state = true;
      final user = await ref.read(databaseHelperProvider).fetchUser();
      state = false;
      _userData = user;
    } catch (e) {
      state = false;
      rethrow;
    }
  }
}

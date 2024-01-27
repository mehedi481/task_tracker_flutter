import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_tracker_flutter/controllers/misc/misc_provider.dart';
import 'package:task_tracker_flutter/models/user_model.dart';

class ProfileDataController extends StateNotifier<UserModel?> {
  final Ref ref;
  ProfileDataController(this.ref) : super(null) {
    refreshProfileData();
  }

  Future<void> refreshProfileData() async {
    try {
      // Fetch user data from local storage or API
      UserModel? userData = await ref.read(databaseHelperProvider).fetchUser();
      state = userData;
    } catch (e) {
      print('Error refreshing profile data: $e');
    }
  }
}

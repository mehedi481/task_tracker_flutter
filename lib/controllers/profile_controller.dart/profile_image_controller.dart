import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_tracker_flutter/services/profile_service_provider.dart';

class ProfileImageUpdateController extends StateNotifier<bool> {
  ProfileImageUpdateController(this.ref) : super(false);

  final Ref ref;

  Future<bool> updateProfileImage({required String image}) async {
    state = true;
    try {
      final response =
          await ref.read(profileServiceProvider).updateProfileImage(img: image);
      if (response.statusCode == 200) {
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

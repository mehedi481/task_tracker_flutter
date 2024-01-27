import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_tracker_flutter/controllers/profile_controller.dart/profile_controller.dart';
import 'package:task_tracker_flutter/controllers/profile_controller.dart/profile_image_controller.dart';
import 'package:task_tracker_flutter/controllers/profile_controller.dart/profile_update_controller.dart';

final profileDataControllerProvider =
    StateNotifierProvider<ProfileDataController, bool>(
  (ref) => ProfileDataController(ref),
);

final profileUpdateControllerProvider =
    StateNotifierProvider<ProfileUpdateController, bool>(
  (ref) => ProfileUpdateController(ref),
);

final profileImageUpdateControllerProvider =
    StateNotifierProvider<ProfileImageUpdateController, bool>(
  (ref) => ProfileImageUpdateController(ref),
);

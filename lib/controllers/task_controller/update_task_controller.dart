import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_tracker_flutter/controllers/task_controller/providers.dart';
import 'package:task_tracker_flutter/services/task_service_provider.dart';

class UpdateTaskController extends StateNotifier<bool> {
  final Ref ref;
  final String id;
  UpdateTaskController(this.ref, this.id) : super(false);

  Future<bool> updateTask({
    required bool isComplete,
  }) async {
    state = true;
    try {
      final response = await ref
          .read(taskServiceProvider)
          .updateTask(id: id, isComplete: isComplete);

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      state = false;
    }
  }
}

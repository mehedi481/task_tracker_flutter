import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_tracker_flutter/services/task_service_provider.dart';

class TaskByStatusController extends StateNotifier<bool> {
  final Ref ref;

  TaskByStatusController(this.ref) : super(false) {
    getAllTask();
  }

  int _inCompleteTaskCount = 0;
  int get inCompleteTaskCount => _inCompleteTaskCount;

  int _completeTaskCount = 0;
  int get completeTaskCount => _completeTaskCount;

  Future<void> getAllTask() async {
    state = true;

    try {
      // Get count of complete tasks
      final response = await ref
          .read(taskServiceProvider)
          .getTaskByCompleteStatus(isComplete: true);
      if (response.statusCode == 200) {
        _completeTaskCount = response.data['count'];
      }

      // Get count of incomplete tasks
      final response2 = await ref
          .read(taskServiceProvider)
          .getTaskByCompleteStatus(isComplete: false);
      if (response2.statusCode == 200) {
        _inCompleteTaskCount = response2.data['count'];
      }
    } catch (e) {
      rethrow;
    } finally {
      state = false;
    }
  }
}

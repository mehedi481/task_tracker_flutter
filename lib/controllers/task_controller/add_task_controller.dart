import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_tracker_flutter/services/task_service_provider.dart';

class AddTaskController extends StateNotifier<bool> {
  final Ref ref;
  AddTaskController(this.ref) : super(false);

  Future<bool> addTask({
    required String title,
    required String description,
    required String dueDate,
  }) async {
    state = true;
    try {
      final response = await ref
          .read(taskServiceProvider)
          .createTask(title: title, description: description, dueDate: dueDate);

      if (response.statusCode == 201) {
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

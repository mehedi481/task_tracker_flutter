import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_tracker_flutter/services/task_service_provider.dart';

class DeleteTaskController extends StateNotifier<bool> {
  final Ref ref;
  final String id;
  DeleteTaskController(this.ref, this.id) : super(false);

  Future<bool> deleteTask() async {
    try {
      state = true;
      final response = await ref.read(taskServiceProvider).deleteTask(id: id);
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

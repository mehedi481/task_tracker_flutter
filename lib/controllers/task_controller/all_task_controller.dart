import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_tracker_flutter/controllers/task_controller/providers.dart';
import 'package:task_tracker_flutter/models/task_model.dart';
import 'package:task_tracker_flutter/services/task_service_provider.dart';

class AllTaskController extends StateNotifier<bool> {
  final Ref ref;
  AllTaskController(this.ref) : super(false) {
    getAllTask();
  }

  List<TaskModel> _taskList = [];
  List<TaskModel> get taskList => _taskList;

  Future<void> getAllTask() async {
    state = true;
    try {
      final response = await ref.read(taskServiceProvider).getAllTask();
      if (response.statusCode == 200) {
        List<dynamic> list = response.data['data'];
        _taskList = await compute(parseTaskList, list);
        // for refreshing summary task count
        ref.invalidate(getTaskByStatusControllerProvider);
      }
    } catch (e) {
      rethrow;
    } finally {
      state = false;
    }
  }
}

List<TaskModel> parseTaskList(List<dynamic> list) {
  return list.map((value) => TaskModel.fromMap(value)).toList();
}

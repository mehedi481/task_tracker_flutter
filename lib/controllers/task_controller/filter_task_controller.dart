import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_tracker_flutter/models/task_model.dart';
import 'package:task_tracker_flutter/services/task_service_provider.dart';

class FilterTaskController extends StateNotifier<bool> {
  final Ref ref;
  final DateTime selectedDate;
  FilterTaskController(this.ref, this.selectedDate) : super(false) {
    getAllTask();
  }

  List<TaskModel> _filteredList = [];
  List<TaskModel> get filteredTaskList => _filteredList;

  Future<void> getAllTask() async {
    state = true;
    try {
      final response = await ref.read(taskServiceProvider).getAllTask();
      if (response.statusCode == 200) {
        List<dynamic> list = response.data['data'];
        // Assign the filtered list to _filteredList
        List<TaskModel> temp = await compute(parseTaskList, list);
        _filteredList = temp
            .where((task) =>
                task.dueDate != null &&
                task.dueDate!.year == selectedDate.year &&
                task.dueDate!.month == selectedDate.month &&
                task.dueDate!.day == selectedDate.day)
            .toList();
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

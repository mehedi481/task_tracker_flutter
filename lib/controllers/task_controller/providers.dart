import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_tracker_flutter/controllers/task_controller/add_task_controller.dart';
import 'package:task_tracker_flutter/controllers/task_controller/all_task_controller.dart';

final addTaskControllerProvider =
    StateNotifierProvider<AddTaskController, bool>(
  (ref) => AddTaskController(ref),
);

final allTaskControllerProvider =
    StateNotifierProvider<AllTaskController, bool>(
  (ref) => AllTaskController(ref),
);

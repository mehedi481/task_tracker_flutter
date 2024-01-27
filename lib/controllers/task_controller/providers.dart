import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_tracker_flutter/controllers/task_controller/add_task_controller.dart';
import 'package:task_tracker_flutter/controllers/task_controller/all_task_controller.dart';
import 'package:task_tracker_flutter/controllers/task_controller/delete_task.dart';
import 'package:task_tracker_flutter/controllers/task_controller/filter_task_controller.dart';
import 'package:task_tracker_flutter/controllers/task_controller/get_task_by_complete_status.dart';
import 'package:task_tracker_flutter/controllers/task_controller/update_task_controller.dart';

final addTaskControllerProvider =
    StateNotifierProvider<AddTaskController, bool>(
  (ref) => AddTaskController(ref),
);

final allTaskControllerProvider =
    StateNotifierProvider<AllTaskController, bool>(
  (ref) => AllTaskController(ref),
);

final updateTaskControllerProvider =
    StateNotifierProvider.family<UpdateTaskController, bool, String>(
  (ref, id) => UpdateTaskController(ref, id),
);

final getTaskByStatusControllerProvider =
    StateNotifierProvider<TaskByStatusController, bool>(
  (ref) => TaskByStatusController(ref),
);

final deleteTaskControllerProvider =
    StateNotifierProvider.family<DeleteTaskController, bool, String>(
  (ref, id) => DeleteTaskController(ref, id),
);

final filterTaskControllerProvider =
    StateNotifierProvider.family<FilterTaskController, bool, DateTime>(
  (ref, selectedDate) => FilterTaskController(ref, selectedDate),
);

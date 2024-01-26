import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_tracker_flutter/config/app_constants.dart';
import 'package:task_tracker_flutter/utils/api_client.dart';

final taskServiceProvider = Provider((ref) => TaskService(ref));

abstract class TaskRepository {
  Future<Response> getAllTask();
  Future<Response> createTask({
    required String title,
    required String description,
    required String dueDate,
  });
}

class TaskService implements TaskRepository {
  final Ref ref;
  TaskService(this.ref);

  @override
  Future<Response> getAllTask() async {
    final response = await ref.read(apiClientProvider).get(AppConstants.task);
    return response;
  }

  @override
  Future<Response> createTask({
    required String title,
    required String description,
    required String dueDate,
  }) async {
    final response =
        await ref.read(apiClientProvider).post(AppConstants.task, data: {
      "title": title,
      "description": description,
      "dueDate": dueDate,
    });
    return response;
  }
}

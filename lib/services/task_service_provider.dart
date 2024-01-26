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
  Future<Response> updateTask({
    required String id,
    required bool isComplete,
  });
  Future<Response> getTaskByCompleteStatus({required bool isComplete});
  Future<Response> deleteTask({required String id});
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

  @override
  Future<Response> updateTask({required String id, required bool isComplete}) {
    final response =
        ref.read(apiClientProvider).put("${AppConstants.task}/$id", data: {
      "completed": isComplete,
    });
    return response;
  }

  @override
  Future<Response> getTaskByCompleteStatus({required bool isComplete}) {
    final response = ref.read(apiClientProvider).get(AppConstants.task, query: {
      "completed": isComplete,
    });
    return response;
  }

  @override
  Future<Response> deleteTask({required String id}) {
    final response =
        ref.read(apiClientProvider).delete("${AppConstants.task}/$id");
    return response;
  }
}

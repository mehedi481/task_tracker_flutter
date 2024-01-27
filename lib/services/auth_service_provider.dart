import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_tracker_flutter/config/app_constants.dart';
import 'package:task_tracker_flutter/utils/api_client.dart';

final authServiceProvider = Provider((ref) => AuthService(ref));

abstract class AuthRepository {
  Future<Response> login({
    required String email,
    required String password,
  });
  Future<Response> register({
    required String name,
    required String email,
    required String password,
    required int age,
  });

  Future<Response> logout();
}

class AuthService implements AuthRepository {
  final Ref ref;
  AuthService(this.ref);

  @override
  Future<Response> login(
      {required String email, required String password}) async {
    final response =
        await ref.read(apiClientProvider).post(AppConstants.login, data: {
      "email": email,
      "password": password,
    });

    return response;
  }

  @override
  Future<Response> register({
    required String name,
    required String email,
    required String password,
    required int age,
  }) {
    final response =
        ref.read(apiClientProvider).post(AppConstants.register, data: {
      "name": name,
      "email": email,
      "password": password,
      "age": age,
    });
    return response;
  }

  @override
  Future<Response> logout() {
    final response = ref.read(apiClientProvider).post(AppConstants.logout);
    return response;
  }
}

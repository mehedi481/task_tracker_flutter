import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_tracker_flutter/config/app_constants.dart';
import 'package:task_tracker_flutter/utils/api_client.dart';

final profileServiceProvider = Provider((ref) => ProfileService(ref));

abstract class ProfileRepository {
  Future<Response> profileUpdate({required Map<String, dynamic> data});
  Future<Response> updateProfileImage({required String img});
}

class ProfileService implements ProfileRepository {
  final Ref ref;
  ProfileService(this.ref);

  @override
  Future<Response> profileUpdate({required Map<String, dynamic> data}) async {
    final response = await ref
        .read(apiClientProvider)
        .put(AppConstants.profileUpdate, data: data);
    return response;
  }

  @override
  Future<Response> updateProfileImage({required String img}) async {
    final response = await ref
        .read(apiClientProvider)
        .post(AppConstants.profileImageUpdate, data: {
      "avatar": img,
    });
    return response;
  }
}

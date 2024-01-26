import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:task_tracker_flutter/config/app_constants.dart';
import 'package:task_tracker_flutter/utils/routes.dart';
import 'package:task_tracker_flutter/utils/utils.dart';

void addApiInterceptors(Dio dio) {
  dio.options.connectTimeout = const Duration(seconds: 20);
  dio.options.receiveTimeout = const Duration(seconds: 10);
  dio.options.headers['Accept'] = 'application/json';
  dio.options.headers['accept'] = "application/json";
  // logger
  dio.interceptors.add(PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseBody: true,
    responseHeader: false,
    error: true,
    compact: true,
    maxWidth: 90,
  ));

  // respone handler
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        final authBox = Hive.box(AppConstants.authBox);
        final token = authBox.get(AppConstants.authToken);
        options.headers['Authorization'] = "Bearer $token";
        handler.next(options);
      },
      onResponse: (response, handler) {
        final message = response.data['message'];

        switch (response.statusCode) {
          case 401:
            Box authBox = Hive.box(AppConstants.authBox);
            authBox.delete(AppConstants.authToken);
            Utils.navigatorKey.currentState
                ?.pushNamedAndRemoveUntil(Routes.logIn, (route) => false);
            Utils.showCustomSnackbar(
              message: message,
              isSuccess: false,
            );
            break;
          case 302:
          case 400:
          case 403:
          case 404:
          case 409:
          case 422:
          case 500:
            Utils.showCustomSnackbar(
              message: message,
              isSuccess: false,
            );
            break;
          default:
            break;
        }
        handler.next(response);
      },
      onError: (error, handler) {
        switch (error.type) {
          case DioExceptionType.connectionError:
          case DioExceptionType.connectionTimeout:
          case DioExceptionType.badResponse:
          case DioExceptionType.sendTimeout:
          case DioExceptionType.receiveTimeout:
          case DioExceptionType.unknown:
            Utils.showCustomSnackbar(
              message: 'An unknown error occurred',
              isSuccess: false,
            );
            break;
          default:
            break;
        }
        if (error.response != null) {
          final message = error.response!.data['message'];
          final statusCode = error.response!.statusCode;
          switch (statusCode) {
            case 401:
              Box authBox = Hive.box(AppConstants.authBox);
              authBox.delete(AppConstants.authToken);
              Utils.navigatorKey.currentState
                  ?.pushNamedAndRemoveUntil(Routes.logIn, (route) => false);
              break;
            case 403:
              Utils.showCustomSnackbar(
                message: message,
                isSuccess: false,
              );
              break;
            default:
              Utils.showCustomSnackbar(
                message: 'unexpected error',
                isSuccess: false,
              );
              break;
          }
        }
        handler.reject(error);
      },
    ),
  );
}

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:task_tracker_flutter/database/database_helper.dart';
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
      onRequest: (options, handler) async {
        String? token = await DatabaseHelper.instance.fetchUserToken();
        options.headers['Authorization'] = "Bearer $token";
        handler.next(options);
      },
      onResponse: (response, handler) async {
        final message = response.data['message'];

        switch (response.statusCode) {
          case 401:
            await DatabaseHelper.instance.deleteUserToken();
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
      onError: (error, handler) async {
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
              await DatabaseHelper.instance.deleteUserToken();
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

import 'package:dio/dio.dart';
import 'package:hrm_app/models/error/error_response.dart';

import '../network_constants.dart';
import 'error_exception.dart';

class NetworkHandler {
  static ErrorException handleError(DioError error) {
    return _handleError(error);
  }

  static ErrorException _handleError(error) {
    if (error is! DioError) {
      return ErrorException(
          NetworkConstants.ERROR_TITLE, NetworkConstants.ERROR_MESSAGE_NETWORK);
    }

    if (_isNetWorkError(error)) {
      return ErrorException(
          NetworkConstants.ERROR_TITLE, NetworkConstants.ERROR_MESSAGE_NETWORK);
    }
    final parsedException = _parseError(error);
    // final errorCode = error.response?.statusCode;
    // if (errorCode == 401) {
    //   // eventBus.fire(UnAuthEvent(""));
    //   return UnauthorizedException();
    // }
    // if (errorCode == 503) {
    //   return MaintenanceException();
    // }
    return parsedException;
  }

  static bool _isNetWorkError(DioError error) {
    final errorType =
        error.type; // `error.type` sẽ trả về kiểu `DioExceptionType`
    switch (errorType) {
      case DioExceptionType.cancel:
        return true;
      case DioExceptionType.connectionTimeout:
        return true;
      case DioExceptionType.receiveTimeout:
        return true;
      case DioExceptionType.sendTimeout:
        return true;
      case DioExceptionType.unknown:
        return true;
      case DioExceptionType.badResponse:
        return false;
      case DioExceptionType.connectionError:
        return true;
      default:
        return true;
    }
  }

  static ErrorException _parseError(DioError error) {
    if (error.response?.data is! Map<String, dynamic>) {
      return ErrorException(
          NetworkConstants.ERROR_TITLE, NetworkConstants.ERROR_MESSAGE_NETWORK);
    }
    final errorResponse = ErrorResponse.fromJson(error.response?.data);
    return ErrorException(NetworkConstants.ERROR_TITLE,
        errorResponse.message ?? NetworkConstants.ERROR_MESSAGE_NETWORK);
  }
}

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hrm_app/services/network/exceptions/error_exception.dart';
import 'package:hrm_app/services/network/exceptions/network_handler.dart';
import 'package:hrm_app/services/network/network_checker.dart';
import 'package:hrm_app/utils/logger.dart';
import '../network_constants.dart';
part 'result.freezed.dart';

@freezed
abstract class Result<T> with _$Result<T> {
  const factory Result.success(T data) = Success<T>;

  const factory Result.error(ErrorException exception) = Error<T>;
}

Result<T> runCatching<T>(T Function() block) {
  try {
    return Result.success(block());
  } catch (e) {
    return Result.error(
      ErrorException(
        NetworkConstants.ERROR_TITLE,
        NetworkConstants.ERROR_MESSAGE_NETWORK,
      ),
    );
  }
}

Future<Result<T>> runCatchingAsync<T>(Future<T> Function() block) async {
  final connected = await NetworkChecker.checkNetwork();
  if (!connected) {
    return Result.error(NoNetworkException());
  }
  try {
    final response = await block();
    return Result.success(response);
  } catch (e) {
    logger.e(e);
    if (e is DioError) {
      return Result.error(NetworkHandler.handleError(e));
    } else {
      return Result.error(
        ErrorException(
          NetworkConstants.ERROR_TITLE,
          NetworkConstants.ERROR_MESSAGE_NETWORK,
        ),
      );
    }
  }
}

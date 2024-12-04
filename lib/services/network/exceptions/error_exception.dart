
import '../network_constants.dart';

class ErrorException implements Exception {
  String title;
  String message;

  ErrorException(this.title, this.message);

  @override
  String toString() => '$title $message';
}

class CommonException extends ErrorException {
  CommonException()
      : super(NetworkConstants.ERROR_TITLE, NetworkConstants.ERROR_MESSAGE_NETWORK);
}

class NoNetworkException extends ErrorException {
  NoNetworkException()
      : super(NetworkConstants.ERROR_TITLE,
      NetworkConstants.ERROR_MESSAGE_NETWORK);
}

class ExpiredException extends ErrorException {
  ExpiredException()
      : super(NetworkConstants.ERROR_TITLE,
      NetworkConstants.ERROR_MESSAGE_NETWORK);
}

class UnauthorizedException extends ErrorException {
  UnauthorizedException()
      : super(NetworkConstants.ERROR_TITLE,
      NetworkConstants.ERROR_MESSAGE_NETWORK);
}

class MaintenanceException extends ErrorException {
  MaintenanceException()
      : super(NetworkConstants.ERROR_TITLE,
      NetworkConstants.ERROR_MESSAGE_NETWORK);
}
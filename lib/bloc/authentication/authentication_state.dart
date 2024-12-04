part of 'authentication_bloc.dart';

sealed class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoginInitial extends AuthState {
  AuthLoginInitial({required this.email, required this.password});

  final String email;
  final String password;
}

class AuthLoginInProgress extends AuthState {}

class AuthLoginSuccess extends AuthState {}

class AuthLoginFailure extends AuthState {
  AuthLoginFailure(this.message);

  final String message;
}

class AuthAuthenticateSuccess extends AuthState {
  AuthAuthenticateSuccess(this.user);

  final User user;
}

class AuthAuthenticateFailure extends AuthState {
  AuthAuthenticateFailure(this.message);

  final String message;
}

class AuthAuthenticateUnauthenticated extends AuthState {
  AuthAuthenticateUnauthenticated({
    this.data,
  });
  final LoginInfo? data;
}

class AuthLogoutSuccess extends AuthState {}

class AuthLogoutFailure extends AuthState {
  AuthLogoutFailure(this.message);

  final String message;
}

class AuthSessionExpired extends AuthState {}
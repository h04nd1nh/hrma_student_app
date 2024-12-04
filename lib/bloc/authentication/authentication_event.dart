part of 'authentication_bloc.dart';

sealed class AuthEvent {}

class AuthStarted extends AuthEvent {}

class AuthLoginStartedCheck extends AuthEvent {}

class AuthLoginStarted extends AuthEvent {
  AuthLoginStarted(
      {required this.email,
      required this.password,
      required this.rememberPassword});

  final String email;
  final String password;
  final bool rememberPassword;
}

class AuthLoginPrefilled extends AuthEvent {
  AuthLoginPrefilled({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}

class AuthAuthenticateStarted extends AuthEvent {}

class AuthLogoutStarted extends AuthEvent {}

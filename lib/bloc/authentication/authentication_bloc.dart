import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_app/models/authentication/authentication_response.dart';
import 'package:hrm_app/services/network/dio/result.dart';

import '../../services/repository/authentication/authentication_repository.dart';
import '../../models/models.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<AuthStarted>(_onStarted);
    on<AuthLoginStartedCheck>(_onStartedCheckRememberLogin);
    on<AuthLoginStarted>(_onLoginStarted);
    on<AuthLoginPrefilled>(_onLoginPrefilled);
    on<AuthAuthenticateStarted>(_onAuthenticateStarted);
    on<AuthLogoutStarted>(_onLogoutStarted);
  }

  final AuthenticationRepositoryImp authRepository;

  Future<void> _onStarted(AuthStarted event, Emitter<AuthState> emit) async {
    emit(AuthAuthenticateUnauthenticated());
  }

  Future<void> _onStartedCheckRememberLogin(
      AuthLoginStartedCheck event, Emitter<AuthState> emit) async {
    final result = await authRepository.getLoginInfo();
    if (result != null) {
      emit(AuthAuthenticateUnauthenticated(data: result));
    } else {
      emit(AuthAuthenticateUnauthenticated());
    }
  }

  Future<void> _onLoginStarted(
      AuthLoginStarted event, Emitter<AuthState> emit) async {
    emit(AuthLoginInProgress());
    await Future<void>.delayed(const Duration(seconds: 1));
    final result = await authRepository.login(
        login: event.email,
        password: event.password,
        rememberMe: event.rememberPassword);
    if (result is Success) {
      emit(AuthLoginSuccess());
    } else {
      emit(AuthLoginFailure("Đăng nhập thất bại"));
    }
  }

  Future<void> _onLoginPrefilled(
    AuthLoginPrefilled event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoginInitial(email: event.email, password: event.password));
  }

  Future<void> _onAuthenticateStarted(
    AuthAuthenticateStarted event,
    Emitter<AuthState> emit,
  ) async {
    final accessToken = await authRepository.getAccessToken();
    final user = await authRepository.getUserInfo();
    if (accessToken != null && user != null) {
      emit(AuthAuthenticateSuccess(user));
    } else {
      emit(AuthAuthenticateUnauthenticated());
    }
  }

  Future<void> _onLogoutStarted(
    AuthLogoutStarted event,
    Emitter<AuthState> emit,
  ) async {
    await authRepository.logout();
    emit(AuthLogoutSuccess());
  }
}

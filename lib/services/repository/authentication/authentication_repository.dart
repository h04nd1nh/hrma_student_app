import 'dart:developer';
import 'dart:io';

import 'package:hrm_app/core/injectors.dart';
import 'package:hrm_app/models/authentication/authentication_response.dart';
import 'package:hrm_app/services/network/client/base_client.dart';
import 'package:hrm_app/services/network/dio/result.dart';
import 'package:hrm_app/services/network/exceptions/error_exception.dart';

import '../../../models/models.dart';
import '../../../models/DTOs/login_dto.dart';
import '../../local_data_source/authentication_local_data_source.dart';

abstract class AuthenticationRepository {
  Future<Result<void>> login(
      {required String login,
      required String password,
      required bool rememberMe});
}

class AuthenticationRepositoryImp extends AuthenticationRepository {
  final AuthLocalDataSource authLocalDataSource;
  final BaseClient _baseClient = injector();

  AuthenticationRepositoryImp({
    required this.authLocalDataSource,
  });

  @override
  Future<Result<void>> login(
      {required String login,
      required String password,
      required bool rememberMe}) async {
    final response =
        await _baseClient.login(LoginDto(login: login, password: password));

    if (response.data.status == 'success') {
      //Cookie, accessToken and refreshToken

      final userInformation = response.data.user;

      // Save local data
      await Future.wait([
        authLocalDataSource.saveAuthInfo(
          accessToken: userInformation!.accessToken,
        ),
        authLocalDataSource.deleteLoginInfo(),
        authLocalDataSource.saveUser(userInformation)
      ]);

      if (rememberMe) {
        await authLocalDataSource
            .rememberLoginInfo(LoginInfo(login: login, password: password));
      } else {
        await authLocalDataSource.rememberLoginInfo(LoginInfo(login: login));
      }

      return const Result.success(null);
    } else {
      return Result.error(ErrorException(
          'Đăng nhập',
          response.data.message ??
              "Đăng nhập không thành công, vui lòng thử lại"));
    }
  }

  //
  // ** Get Accesstoken of user
  //
  Future<String?> getAccessToken() async {
    try {
      final token = await authLocalDataSource.getAccessToken();
      if (token == null) {
        return null;
      }
      return token;
    } catch (e) {
      log('$e');
      return null;
    }
  }

  //
  // ** Get login infomation (login, password) if user choose remember login option
  //
  Future<LoginInfo?> getLoginInfo() async {
    try {
      // Get login information from authLocalDataSource
      final data = await authLocalDataSource.getLoginInfo();
      return data;
    } catch (e) {
      // Nếu có lỗi, trả về một Failure
      return null;
    }
  }

  Future<User?> getUserInfo() async {
    try {
      // Get login information from authLocalDataSource
      final data = await authLocalDataSource.getUser();
      if (data != null) {
        return data;
      }
      return null;
    } catch (e) {
      // Nếu có lỗi, trả về một Failure
      return null;
    }
  }

  Future<void> logout() async {
    try {
      await authLocalDataSource.deleteAuthInfo();
      await authLocalDataSource.deleteUser();
    } catch (e) {
      log('$e');
    }
  }
}

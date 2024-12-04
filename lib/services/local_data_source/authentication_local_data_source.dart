import 'dart:convert';
import 'package:hrm_app/models/authentication/authentication_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/models.dart';

class AuthLocalDataSource {
  AuthLocalDataSource();
  // final storage = const FlutterSecureStorage();

  Future<void> saveAccessToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('accessToken', token);
    // await storage.write(key: 'accessToken', value: token);
  }

  Future<String?> getAccessToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString('accessToken');
    // return storage.read(key: 'accessToken');
  }

  Future<void> deleteAccessToken() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove('accessToken');
    // await storage.delete(key: 'accessToken');
  }

  Future<void> saveAuthInfo({
    required String accessToken,
  }) async {
    final pref = await SharedPreferences.getInstance();
    await Future.wait([
      pref.setString('accessToken', accessToken),
      // storage.write(key: 'accessToken', value: accessToken),
      // storage.write(key: 'refreshToken', value: refreshToken),
      // storage.write(key: 'sessionId', value: sessionId),
    ]);
  }

  Future<void> deleteAuthInfo() async {
    final pref = await SharedPreferences.getInstance();
    await Future.wait([
      pref.remove('accessToken'),
      // storage.delete(key: 'accessToken'),
      // storage.delete(key: 'refreshToken'),
      // storage.delete(key: 'sessionId'),
    ]);
  }

  // Remember Login
  Future<void> rememberLoginInfo(LoginInfo loginInfo) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('email', loginInfo.login);
    if (loginInfo.password != null) {
      await pref.setString('password', loginInfo.password!);
    }
  }

  Future<LoginInfo> getLoginInfo() async {
    final pref = await SharedPreferences.getInstance();
    String? email = pref.getString('email');
    String? password = pref.getString('password');
    if (password == null) {
      return LoginInfo(login: email!);
    } else {
      return LoginInfo(login: email!, password: password);
    }
  }

  Future<void> deleteLoginInfo() async {
    final pref = await SharedPreferences.getInstance();
    pref.remove('email');
    pref.remove('password');
  }

  // For save user information
  // Remember User
  Future<void> saveUser(User user) async {
    final pref = await SharedPreferences.getInstance();
    final userJson = jsonEncode(user.toJson());
    await pref.setString('user', userJson);
  }

  Future<User?> getUser() async {
    final pref = await SharedPreferences.getInstance();
    final String? userJson = pref.getString('user');
    if (userJson != null) {
      final Map<String, dynamic> userMap = jsonDecode(userJson);
      return User.fromJson(userMap);
    }
    return null;
  }

  Future<void> deleteUser() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove('user');
  }
}

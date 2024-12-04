class LoginDto {
  const LoginDto({
    required this.login,
    required this.password,
  });

  final String login;
  final String password;

  Map<String, dynamic> toJson() => {
        'identifier': login,
        'password': password,
      };
}

class LoginInfo {
  const LoginInfo({
    required this.login,
    this.password,
  });

  final String login;
  final String? password;
}

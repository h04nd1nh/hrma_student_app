import 'package:json_annotation/json_annotation.dart';

part 'authentication_response.g.dart';

@JsonSerializable()
class AuthenticationResponse {
  @JsonKey(name: "status")
  final String status;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "data")
  final User? user;

  AuthenticationResponse(this.status, this.message, this.user);

  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}

@JsonSerializable()
class User {
  @JsonKey(name: "id")
  final int id;

  @JsonKey(name: "identifier")
  final String identifier;

  @JsonKey(name: "fullname")
  final String fullName;

  @JsonKey(name: "access_token")
  final String accessToken;

  @JsonKey(name: "role")
  final String role;

  User(this.id, this.identifier, this.fullName, this.accessToken, this.role);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

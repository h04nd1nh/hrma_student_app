import 'package:json_annotation/json_annotation.dart';

part 'action_response.g.dart';

@JsonSerializable()
class ActionResponse {
  @JsonKey(name: "success")
  final bool? success;

  @JsonKey(name: "message")
  final String? message;

  ActionResponse(this.success, this.message);

  factory ActionResponse.fromJson(Map<String, dynamic> json) =>
      _$ActionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ActionResponseToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'session_request.g.dart';

@JsonSerializable()
class SessionBody {
  @JsonKey(name: "time_table_teacher_id")
  final int timeTableTeacherId;

  SessionBody({required this.timeTableTeacherId});

  factory SessionBody.fromJson(Map<String, dynamic> json) =>
      _$SessionBodyFromJson(json);
  Map<String, dynamic> toJson() => _$SessionBodyToJson(this);
}

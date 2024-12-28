import 'package:json_annotation/json_annotation.dart';

part 'session_teacher_response.g.dart';

@JsonSerializable()
class SessionTeacherResponse {
  @JsonKey(name: "success")
  final bool success;

  @JsonKey(name: "session")
  final Session? session;

  @JsonKey(name: "checked_in_students")
  final List<StudentInfomation?> checkedInStudent;

  @JsonKey(name: "not_checked_in_students")
  final List<StudentInfomation?> notCheckinInStudent;

  SessionTeacherResponse(this.success, this.session, this.checkedInStudent,
      this.notCheckinInStudent);

  factory SessionTeacherResponse.fromJson(Map<String, dynamic> json) =>
      _$SessionTeacherResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SessionTeacherResponseToJson(this);
}

@JsonSerializable()
class Session {
  @JsonKey(name: "id")
  final int id;

  @JsonKey(name: "timetable_id")
  final int timeTableTeacherId;

  @JsonKey(name: "start_time")
  final String startTime;

  Session(this.id, this.timeTableTeacherId, this.startTime);

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);
  Map<String, dynamic> toJson() => _$SessionToJson(this);
}

@JsonSerializable()
class StudentInfomation {
  @JsonKey(name: "id")
  final int id;

  @JsonKey(name: "fullname")
  final String fullName;

  @JsonKey(name: "email")
  final String email;

  StudentInfomation(this.id, this.fullName, this.email);

  factory StudentInfomation.fromJson(Map<String, dynamic> json) =>
      _$StudentInfomationFromJson(json);
  Map<String, dynamic> toJson() => _$StudentInfomationToJson(this);
}

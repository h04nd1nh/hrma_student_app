import 'package:json_annotation/json_annotation.dart';

part 'timetable_student.g.dart';

@JsonSerializable()
class TimetableStudentResponse {
  @JsonKey(name: "success")
  final bool success;

  @JsonKey(name: "time_table")
  final List<TimeTable> timeTable;

  TimetableStudentResponse(this.success, this.timeTable);

  factory TimetableStudentResponse.fromJson(Map<String, dynamic> json) =>
      _$TimetableStudentResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TimetableStudentResponseToJson(this);
}

@JsonSerializable()
class TimeTableStudent {
  @JsonKey(name: "id")
  final int id;

  @JsonKey(name: "student_id")
  final int studentId;

  @JsonKey(name: "time_table_teacher_id")
  final int timeTableTeacherId;

  @JsonKey(name: "teacher_name")
  final String teacherName;

  @JsonKey(name: "title")
  final String title;

  @JsonKey(name: "period_id")
  final int periodId;

  @JsonKey(name: "period_name")
  final String periodName;

  @JsonKey(name: "room_id")
  final int roomId;

  @JsonKey(name: "room_name")
  final String roomName;

  @JsonKey(name: "date")
  final String date;

  @JsonKey(name: "is_checkin")
  final bool isCheckin;

  TimeTableStudent(
      {required this.id,
      required this.studentId,
      required this.timeTableTeacherId,
      required this.teacherName,
      required this.title,
      required this.periodId,
      required this.periodName,
      required this.roomId,
      required this.roomName,
      required this.date,
      required this.isCheckin});

  factory TimeTableStudent.fromJson(Map<String, dynamic> json) =>
      _$TimeTableStudentFromJson(json);
  Map<String, dynamic> toJson() => _$TimeTableStudentToJson(this);
}

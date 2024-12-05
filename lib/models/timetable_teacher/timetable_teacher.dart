import 'package:json_annotation/json_annotation.dart';

part 'timetable_teacher.g.dart';

@JsonSerializable()
class TimeTableTeacher {
  @JsonKey(name: "id")
  final int id;

  @JsonKey(name: "teacher_id")
  final int teacherId;

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

  TimeTableTeacher(
      {required this.id,
      required this.teacherId,
      required this.teacherName,
      required this.title,
      required this.periodId,
      required this.periodName,
      required this.roomId,
      required this.roomName,
      required this.date});

  factory TimeTableTeacher.fromJson(Map<String, dynamic> json) =>
      _$TimeTableTeacherFromJson(json);
  Map<String, dynamic> toJson() => _$TimeTableTeacherToJson(this);
}

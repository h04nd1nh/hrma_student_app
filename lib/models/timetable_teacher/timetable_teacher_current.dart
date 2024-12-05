import 'package:hrm_app/models/timetable_teacher/timetable_teacher.dart';
import 'package:json_annotation/json_annotation.dart';

part 'timetable_teacher_current.g.dart';

@JsonSerializable()
class TimetableTeacherCurrentResponse {
  @JsonKey(name: "success")
  final bool success;

  @JsonKey(name: "time_table")
  final TimeTableTeacher? timeTable;

  TimetableTeacherCurrentResponse(this.success, this.timeTable);

  factory TimetableTeacherCurrentResponse.fromJson(Map<String, dynamic> json) =>
      _$TimetableTeacherCurrentResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$TimetableTeacherCurrentResponseToJson(this);
}

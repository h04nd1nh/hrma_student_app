import 'package:hrm_app/models/timetable_teacher/timetable_teacher.dart';
import 'package:json_annotation/json_annotation.dart';

part 'timetable_teacher_response.g.dart';

@JsonSerializable()
class TimetableTeacherResponse {
  @JsonKey(name: "success")
  final bool success;

  @JsonKey(name: "time_table")
  final List<TimeTableTeacher?> timeTable;

  TimetableTeacherResponse(this.success, this.timeTable);

  factory TimetableTeacherResponse.fromJson(Map<String, dynamic> json) =>
      _$TimetableTeacherResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TimetableTeacherResponseToJson(this);
}

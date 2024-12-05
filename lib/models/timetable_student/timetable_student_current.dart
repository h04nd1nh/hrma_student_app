import 'package:hrm_app/models/timetable_student/timetable_student.dart';
import 'package:json_annotation/json_annotation.dart';

part 'timetable_student_current.g.dart';

@JsonSerializable()
class TimetableStudentCurrentResponse {
  @JsonKey(name: "success")
  final bool success;

  @JsonKey(name: "time_table")
  final TimeTableStudent? timeTable;

  TimetableStudentCurrentResponse(this.success, this.timeTable);

  factory TimetableStudentCurrentResponse.fromJson(Map<String, dynamic> json) =>
      _$TimetableStudentCurrentResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$TimetableStudentCurrentResponseToJson(this);
}

import 'package:hrm_app/models/timetable_student/timetable_student.dart';
import 'package:json_annotation/json_annotation.dart';

part 'timetable_student_response.g.dart';

@JsonSerializable()
class TimetableStudentResponse {
  @JsonKey(name: "success")
  final bool success;

  @JsonKey(name: "time_table")
  final List<TimeTableStudent?> timeTable;

  TimetableStudentResponse(this.success, this.timeTable);

  factory TimetableStudentResponse.fromJson(Map<String, dynamic> json) =>
      _$TimetableStudentResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TimetableStudentResponseToJson(this);
}

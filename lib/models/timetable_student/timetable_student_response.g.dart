// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timetable_student_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimetableStudentResponse _$TimetableStudentResponseFromJson(
        Map<String, dynamic> json) =>
    TimetableStudentResponse(
      json['success'] as bool,
      (json['time_table'] as List<dynamic>)
          .map((e) => e == null
              ? null
              : TimeTableStudent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TimetableStudentResponseToJson(
        TimetableStudentResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'time_table': instance.timeTable,
    };

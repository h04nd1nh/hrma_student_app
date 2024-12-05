// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timetable_student_current.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimetableStudentCurrentResponse _$TimetableStudentCurrentResponseFromJson(
        Map<String, dynamic> json) =>
    TimetableStudentCurrentResponse(
      json['success'] as bool,
      json['time_table'] == null
          ? null
          : TimeTableStudent.fromJson(
              json['time_table'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TimetableStudentCurrentResponseToJson(
        TimetableStudentCurrentResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'time_table': instance.timeTable,
    };

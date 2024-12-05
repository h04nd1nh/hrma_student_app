// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timetable_teacher_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimetableTeacherResponse _$TimetableTeacherResponseFromJson(
        Map<String, dynamic> json) =>
    TimetableTeacherResponse(
      json['success'] as bool,
      (json['time_table'] as List<dynamic>)
          .map((e) => e == null
              ? null
              : TimeTableTeacher.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TimetableTeacherResponseToJson(
        TimetableTeacherResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'time_table': instance.timeTable,
    };

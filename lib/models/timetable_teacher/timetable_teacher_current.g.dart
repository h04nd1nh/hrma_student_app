// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timetable_teacher_current.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimetableTeacherCurrentResponse _$TimetableTeacherCurrentResponseFromJson(
        Map<String, dynamic> json) =>
    TimetableTeacherCurrentResponse(
      json['success'] as bool,
      json['time_table'] == null
          ? null
          : TimeTableStudent.fromJson(
              json['time_table'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TimetableTeacherCurrentResponseToJson(
        TimetableTeacherCurrentResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'time_table': instance.timeTable,
    };
